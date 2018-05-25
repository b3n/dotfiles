(use-package persp-mode
  :general (my-leader-def
             "a" #'persp-add-buffer
             "b" #'persp-switch-to-buffer
             "k" #'persp-kill-buffer
             "p" #'persp-frame-switch)

  :diminish persp-mode

  :init
  (setq persp-auto-resume-time -1)
  (setq persp-add-buffer-on-after-change-major-mode 'free)

  :config
  (add-hook 'persp-before-switch-functions
            #'(lambda (new-persp-name w-or-f)
                (let ((cur-persp-name (safe-persp-name (get-current-persp))))
                  (when (member cur-persp-name persp-names-cache)
                    (setq persp-names-cache
                          (cons cur-persp-name
                                (delete cur-persp-name persp-names-cache)))))))

  (add-hook 'persp-renamed-functions
            #'(lambda (persp old-name new-name)
                (setq persp-names-cache
                      (cons new-name (delete old-name persp-names-cache)))))

  (add-hook 'persp-before-kill-functions
            #'(lambda (persp)
                (setq persp-names-cache
                      (delete (safe-persp-name persp) persp-names-cache))))

  (add-hook 'persp-created-functions
            #'(lambda (persp phash)
                (when (and (eq phash *persp-hash*)
                           (not (member (safe-persp-name persp)
                                        persp-names-cache)))
                  (setq persp-names-cache
                        (cons (safe-persp-name persp) persp-names-cache)))))

  (persp-def-auto-persp "@irc" :mode 'erc-mode)

  (persp-mode))

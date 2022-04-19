;; Work (OS X) config


(use-package emacs
  :custom
  (tab-width 2))

(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "Fira Code" :height 150))))
   '(fixed-pitch ((t (:family "JetBrains Mono" :height 145))))
   '(variable-pitch ((t (:family "Libre Baskerville" :height 200))))))


(use-package company
  ;; TODO: Why am I even using this?
  :straight t
  :config
  (global-company-mode))


(use-package js
  :custom
  (js-indent-level 2))


(use-package typescript-mode
  :straight t
  :custom
  (typescript-indent-level 2))


(use-package sh-script
  :custom
  (sh-basic-offset 2))


(use-package magit
  :init
  (defun github-open ()
    "Open Canva GitHub for the current file."
    (interactive)
    (let* ((root (expand-file-name (project-root (project-current t))))
           (repo (car (last (split-string root "/") 2)))
           (path (replace-regexp-in-string (regexp-quote root) "" buffer-file-name))
           (start (line-number-at-pos (region-beginning)))
           (end (line-number-at-pos (region-end))))
      (browse-url (format "https://github.com/Canva/%s/blob/master/%s#L%s-L%s" repo path start end))))
  
  :config
  ;; Monorepo makes git slow, so do a little less on magit refresh
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))


(use-package vterm
  :straight t

  :custom
  (vterm-max-scrollback 100000)
  (vterm-buffer-name-string "vterm<%s>")

  :config
  (define-key vterm-mode-map (kbd "<C-escape>")
    (lambda () (interactive) (vterm-send-key (kbd "C-[")))))


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'"
  :straight t)


(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode)
  :straight t)


(use-package yaml-mode
  :mode "\\.ya?ml\\(\\.j2\\)?\\'"
  :straight t)


(use-package eglot-java
  :init
  (add-hook 'java-mode-hook (lambda ()
                              (electric-indent-local-mode -1)
                              (setq c-basic-offset 2
                                    tab-width 2
                                    evil-shift-width 2
                                    indent-tabs-mode t)))

  :straight t

  :config
  (eglot-java-init))


(provide 'darwin)

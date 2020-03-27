(use-package org
  :straight org-plus-contrib

  :init
  (setq org-src-lang-modes nil) ;; For some reason org-mode fails to load without this being initiated.
  (setq x-selection-timeout 10) ;; https://omecha.info/blog/org-capture-freezes-emacs.html

  :general (my-leader-def
             "o" '(:ignore t :which-key "Org")
             "o a" #'org-agenda
             "o c" #'org-capture
             "o l n" #'org-next-link
             "o l N" #'org-previous-link
             "o l o" #'org-open-at-point-global
             "o l d" '((lambda ()
                         (interactive)
                         (org-insert-link nil
                                          (format-time-string
                                           "file:%F.org"
                                           (org-read-date "" 'totime nil nil (current-time) ""))))
                       :which-key "Insert date file link")
             "o l f" '((lambda ()
                         (interactive)
                         (counsel-rg (concat "\\[\\[file:" (regexp-quote (file-name-nondirectory buffer-file-name)))))
                       :which-key "Find links to this file"))

  :custom
  (org-enforce-todo-dependencies t)
  (org-startup-indented t)
  (org-log-done 'time)
  (org-return-follows-link t)
  (org-link-frame-setup '((file . find-file)))
  (org-link-make-description-function
   (lambda (link desc)
     (if (string-equal (substring link 0 5) "file:")
         (file-name-base (substring link 5))
       desc)))

  :config
  (require 'org-habit)

  (add-hook 'org-mode-hook '(lambda () (visual-line-mode 1)))
  (add-hook 'org-capture-mode-hook 'evil-insert-state)

  (defun my-todo-scheduled-string ()
    (format-time-string (concat "%F" (when org-time-was-given " %T")) my-last-todo-date))
  (setq org-capture-templates
        `(("i" "Todo inbox" entry (file+headline "~/todo.org" "Inbox") "* %?")
          ("t" "Todo" entry
           (file+headline
            ,(lambda ()
               (setq my-last-todo-date (org-read-date nil t))
               (format-time-string "~/wiki/%F.org" my-last-todo-date))
            "Agenda")
           "* TODO %?\nSCHEDULED: <%(my-todo-scheduled-string)>\n")
          ("j" "Journal" entry
           (file ,(lambda () (format-time-string "~/journal/%Y-%m-%d.org")))
           "* %<%H:%M>\n%?\n")))

  (setq org-agenda-files '("~/todo.org" "~/wiki/"))

  (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED"))))


(provide 'init-org)

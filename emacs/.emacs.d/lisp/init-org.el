(use-package org
  :straight org-plus-contrib

  :init
  (setq org-src-lang-modes nil) ;; For some reason org-mode fails to load without this being initiated.
  (setq x-selection-timeout 10) ;; https://omecha.info/blog/org-capture-freezes-emacs.html

  :bind (("C-c o a" . org-agenda)
         ("C-c o c" . org-capture)
         ("C-c o l n" . org-next-link)
         ("C-c o l N" . org-previous-link)
         ("C-c o l o" . org-open-at-point-global)
         ("C-c o l d" . (lambda ()
                          (interactive)
                          (org-insert-link nil
                                           (format-time-string
                                            "file:%F.org"
                                            (org-read-date "" 'totime nil nil (current-time) "")))))
         ("C-c o l f" . (lambda ()
                          (interactive)
                          (counsel-rg (concat "\\[\\[file:" (regexp-quote (file-name-nondirectory buffer-file-name)))))))

  :custom
  (org-enforce-todo-dependencies t)
  (org-startup-indented t)
  (org-log-done 'time)
  (org-return-follows-link t)
  (org-link-frame-setup '((file . find-file)))
  (org-link-make-description-function
   (lambda (link desc)
     (if (string-equal (substring link 0 5) "file:")
         (replace-regexp-in-string "-" " " (file-name-base (substring link 5)))
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

  (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED")))

  (defun my-org-sort-all ()
    "Sort all entries in the current buffer, recursively."
    (interactive)
    (org-map-entries (lambda ()
                       (condition-case x
                           (org-sort-entries nil ?a)
                         (user-error))))))


(provide 'init-org)

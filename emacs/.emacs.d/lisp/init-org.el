(use-package org
  :straight org-plus-contrib

  :init
  (defun my-org-link-date ()
    (interactive)
    (org-insert-link
     nil
     (format-time-string
      "file:%F.org"
      (org-read-date "" 'totime nil nil (current-time) ""))))

  (defun my-org-find-links-here ()
    (interactive)
    (counsel-rg
     (concat
      "\\[\\[file:"
      (regexp-quote (file-name-nondirectory buffer-file-name)))))

  ;;(setq org-src-lang-modes nil) ;; For some reason org-mode fails to load without this being initiated.

  :general
  (my-leader
    "o" '(:ignore t :wk "Org")
    "o a" #'org-agenda
    "o c" #'org-capture
    "o l n" #'org-next-link
    "o l N" #'org-previous-link
    "o l o" #'org-open-at-point-global
    "o l d" #'my-org-link-date
    "o l f" #'my-org-find-links-here)

  :custom
  (org-ellipsis "  ⬎ ")
  (org-enforce-todo-dependencies t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-fontify-whole-heading-line t)
  (org-hidden-keywords '(title))
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-image-actual-width 300)
  (org-link-frame-setup '((file . find-file)))
  (org-log-done 'time)
  (org-pretty-entities t)
  (org-return-follows-link t)
  (org-startup-folded 'content)
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-agenda-files '("~/todo.org"))
  (org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED")))
  (org-capture-templates
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

  :config
  (require 'org-habit)

  (add-hook 'org-capture-mode-hook 'evil-insert-state)

  (defun my-org-sort-all ()
    "Sort all entries in the current buffer, recursively."
    (interactive)
    (org-map-entries (lambda ()
                       (condition-case x
                           (org-sort-entries nil ?a)
                         (user-error))))))


(provide 'init-org)

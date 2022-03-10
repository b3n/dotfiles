(use-package org
  :init
  (setq x-selection-timeout 9) ;; https://omecha.info/blog/org-capture-freezes-emacs.html

  :mode ("\\.org\'" . org-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))

  :straight t

  :custom
  (org-agenda-custom-commands
   '((" " "My agenda"
      ((agenda "")
       (todo "IN-PROGRESS")
       (todo "NEXT")
       (todo "READING")))))
  (org-agenda-files '("~/todo/" "~/notes/books.org"))
  (org-agenda-start-on-weekday nil)
  (org-agenda-window-setup 'current-window)
  (org-capture-templates
        `(("t" "Todo" entry (file+headline "~/todo/inbox.org" "Inbox") "* TODO %?")
          ("n" "Note" entry
           (file ,(lambda () (format-time-string "~/tmp/%Y-%m-%d.org")))
           "* %<%H:%M>\n%?\n")))
  (org-ellipsis "  ⬎ ")
  ;;(org-fontify-quote-and-verse-blocks t)
  ;;(org-fontify-whole-heading-line t)
  ;;(org-hidden-keywords '(title))
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-image-actual-width 300)
  (org-link-frame-setup '((file . find-file)))
  (org-log-done 'time)
  (org-return-follows-link t)
  (org-startup-folded 'content)
  (org-startup-indented t)
  (org-startup-with-inline-images t)

  :config
  (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))

  (require 'org-habit)
  (require 'ob-calc))


(use-package calendar
  :custom
  (calendar-week-start-day 1)
  (calendar-holidays
      '((holiday-fixed 1 1 "New Year's Day")
        (holiday-fixed 2 14 "Valentine's Day")
        (holiday-fixed 3 17 "St. Patrick's Day")
        (holiday-fixed 4 1 "April Fools' Day")
        (holiday-easter-etc -47 "Pancake Day")
        (holiday-easter-etc -21 "Mother's Day")
        (holiday-easter-etc 0 "Easter Sunday")
        (holiday-float 6 0 3 "Father's Day")
        (holiday-fixed 10 31 "Halloween")
        (holiday-fixed 12 24 "Christmas Eve")
        (holiday-fixed 12 25 "Christmas Day")
        (holiday-fixed 12 26 "Boxing Day")
        (holiday-fixed 12 31 "New Year's Eve"))))


(provide 'init-org)

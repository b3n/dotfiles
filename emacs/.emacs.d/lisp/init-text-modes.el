(use-package org
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

  (defun my-org-narrow-forward ()
    "Move to the next subtree at same level, and narrow to it."
    (interactive)
    (widen)
    (org-forward-heading-same-level 1)
    (org-narrow-to-subtree))

  (defun my-org-narrow-backward ()
    "Move to the previous subtree at same level, and narrow to it."
    (interactive)
    (widen)
    (org-backward-heading-same-level 1)
    (org-narrow-to-subtree))

  ;;(setq org-src-lang-modes nil) ;; For some reason org-mode fails to load without this being initiated.

  :mode ("\\.org\'" . org-mode)
  :bind (("C-c o a" . org-agenda)
         ("C-c o c" . org-capture)
         :map org-mode-map
         ("C-c o n" . my-org-narrow-forward) ; TODO: Make Hydra
         ("C-c o N" . my-org-narrow-backward)
         ("C-c o l d" . my-org-link-date)
         ("C-c o l f" . my-org-find-links-here))
  :straight org-plus-contrib

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
  (org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED")
                       (sequence "TO-READ" "CURRENTLY-READING" "|" "READ")
                       (sequence "HABIT" "|" "HABIT-DONE")))
  (org-capture-templates
        `(("t" "Todo inbox" entry (file+headline "~/todo.org" "Inbox") "* %?")
          ("j" "Journal (/tmp)" entry
           (file ,(lambda () (format-time-string "~/tmp/%Y-%m-%d.org")))
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


(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode))
  :straight t)


(use-package tex
  :init
  (setq doc-view-continuous t)

  :defer t
  :straight auctex

  :custom
  (latex-run-command "pdflatex")
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-save-query nil)
  (TeX-PDF-mode t)
  (TeX-view-program-selection '((output-pdf "PDF Tools"))
                              TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
                              TeX-source-correlate-start-server t)
  :config
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))


(use-package csv-mode
  :mode "\\.csv\\'"
  :straight t)


(use-package yaml-mode
  :mode "\\.ya?ml\\'"
  :straight t)


(provide 'init-text-modes)

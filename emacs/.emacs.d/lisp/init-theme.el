(use-package faces
  :straight nil
  :config
  (set-face-attribute 'default nil :family "Iosevka" :height 110)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka")
  (set-face-attribute 'variable-pitch nil :family "Libre Baskerville"))


(use-package face-remap
  :straight nil
  :hook (text-mode . (lambda () (variable-pitch-mode 1)
                       (dolist (face '(org-block-begin-line
                                       org-block-end-line
                                       org-verbatim
                                       org-code
                                       org-block
                                       org-table
                                       org-meta-line
                                       org-document-info-keyword))
                         (set-face-attribute face nil :inherit 'fixed-pitch))
                       (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch)))))


(use-package olivetti
  :hook (text-mode . olivetti-mode)

  :custom
  (olivetti-body-width 99))


(use-package leuven-theme
  :custom
  (org-fontify-whole-heading-line t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)

  :config
  (load-theme 'leuven t)
  (load-theme 'leuven-dark t t)

  (custom-set-faces
   '(hi-yellow ((t (:background "moccasin"))))))


(use-package minions
  :custom
  (minions-mode-line-lighter "...")

  :config
  (minions-mode 1))


(provide 'init-theme)

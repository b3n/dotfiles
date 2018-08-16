(use-package leuven-theme
  :init
  (setq org-fontify-whole-heading-line t)
  :config
  (load-theme 'leuven t)
  (custom-set-faces
   `(lazy-highlight ((t (:background nil :weight bold :slant italic)))))

(use-package leuven-theme
  :disabled
  :init
  (setq org-fontify-whole-heading-line t)
  :config
  (load-theme 'leuven t))

(use-package spacemacs-common
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-light t))

(use-package leuven-theme
  :init
  (setq org-fontify-whole-heading-line t)
  :config
  (load-theme 'leuven t))

(use-package spacemacs-common
  :disabled
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-light t))

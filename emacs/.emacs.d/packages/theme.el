(use-package leuven-theme
  :disabled
  :config
  (setq org-fontify-whole-heading-line t)
  (load-theme 'leuven t))

(use-package doom-themes
  :config (load-theme 'doom-one-light t))

(use-package doom-modeline
  :init
  (global-set-key [mode-line mouse-4] #'my-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-mode-next-buffer)
  :hook
  (after-init . doom-modeline-mode))

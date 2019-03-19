(use-package leuven-theme
  :config
  (setq org-fontify-whole-heading-line t)
  (load-theme 'leuven t))

(use-package doom-themes
  :disabled
  :config (load-theme 'doom-one-light t))

(use-package doom-modeline
  :disabled
  :init
  (global-set-key [mode-line mouse-4] #'my-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-same-mode-next-buffer)
  :hook
  (after-init . doom-modeline-mode))

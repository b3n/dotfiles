(use-package doom-themes
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (load-theme 'doom-one t))

(use-package minions
  :config (minions-mode 1))

(use-package doom-modeline
  :after (minions)
  :init
  (global-set-key [mode-line mouse-4] #'my-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-same-mode-next-buffer)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-minor-modes t))

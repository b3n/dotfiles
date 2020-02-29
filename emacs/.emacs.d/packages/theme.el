(use-package doom-themes
  :disable
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (load-theme 'doom-one-light t t)
  (load-theme 'doom-one t))

(use-package modus-operandi-theme ;; Light
  :ensure t)

(use-package modus-vivendi-theme ;; Dark
  :config
  (load-theme 'modus-vivendi t))

(use-package minions
  :config (minions-mode 1))

(use-package doom-modeline
  :init
  (column-number-mode)
  (global-set-key [mode-line mouse-4] #'my-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-same-mode-next-buffer)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-minor-modes t))

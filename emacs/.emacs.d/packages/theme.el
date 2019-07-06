(use-package leuven-theme
  :init
  (setq org-fontify-whole-heading-line t)
  :config
  (load-theme 'leuven t))

(use-package minions
  :config (minions-mode 1))

(use-package evil-anzu
  :config (global-anzu-mode +1))

(use-package doom-modeline
  :defer 9
  :init
  (global-set-key [mode-line mouse-4] #'my-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-same-mode-next-buffer)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-minor-modes t))

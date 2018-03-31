(use-package which-key
  :after (god-mode)
  :diminish which-key-mode
  :init
  (setq which-key-show-operator-state-maps t)
  :config
  (which-key-mode)
  (which-key-enable-god-mode-support))

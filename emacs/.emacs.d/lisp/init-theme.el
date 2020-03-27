(use-package modus-operandi-theme ;; Light
  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t)

  :config
  (load-theme 'modus-operandi t))

(use-package minions
  :config (minions-mode 1))

(use-package doom-modeline
  :init
  (setq
    display-time-default-load-average nil
    display-time-day-and-date t
    display-time-24hr-format t
  )
  (display-time-mode t)
  (column-number-mode)

  :custom
  (doom-modeline-minor-modes t)

  :config
  (doom-modeline-mode 1))


(provide 'init-theme)

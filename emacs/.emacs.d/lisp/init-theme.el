(use-package modus-operandi-theme ;; Light
  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t)

  :config
  (load-theme 'modus-operandi t))


(use-package modus-vivendi-theme ;; Dark
  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t))


(use-package minions
:config
(minions-mode 1))


(provide 'init-theme)

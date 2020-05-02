(use-package cus-face
  :straight nil

  :config
  (custom-set-faces
   '(default ((t (:family "Iosevka" :height 110))))
   '(fixed-pitch ((t (:family "Iosevka"))))
   '(variable-pitch ((t (:family "Libre Baskerville"))))))


(use-package face-remap
  :straight nil
  :hook (text-mode . variable-pitch-mode))


(use-package olivetti
  :hook (text-mode . olivetti-mode)

  :custom
  (olivetti-body-width 80))


(use-package modus-vivendi-theme
  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t)
  (modus-vivendi-theme-section-headings t)
  (modus-vivendi-theme-distinct-org-blocks t)
  (modus-vivendi-theme-3d-modeline t))


(use-package modus-operandi-theme
  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t)
  (modus-operandi-theme-section-headings t)
  (modus-operandi-theme-distinct-org-blocks t)
  (modus-operandi-theme-3d-modeline t))


(use-package theme-changer
  :after (modus-operandi-theme modus-vivendi-theme)

  :custom
  (calendar-latitude 55.51)
  (calendar-longitude -0.12)

  :config
  (change-theme 'modus-operandi 'modus-vivendi))


(use-package minions
  :custom
  (minions-mode-line-lighter "...")

  :config
  (minions-mode 1))


(use-package fringe
  :straight nil
  :config
  (fringe-mode nil))


(provide 'init-theme)

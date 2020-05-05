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


(use-package modus-vivendi-theme ;; Dark
  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t)
  (modus-vivendi-theme-section-headings t)
  (modus-vivendi-theme-distinct-org-blocks t)
  (modus-vivendi-theme-3d-modeline t)
  (modus-vivendi-theme-scale-5 2)

  :config
  (load-theme 'modus-vivendi t t)
  (run-at-time "19:00" (* 60 60 24) (lambda () (enable-theme 'modus-vivendi))))


(use-package modus-operandi-theme ;; Light
  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t)
  (modus-operandi-theme-section-headings t)
  (modus-operandi-theme-distinct-org-blocks t)
  (modus-operandi-theme-3d-modeline t)
  (modus-operandi-theme-scale-5 2)

  :config
  (load-theme 'modus-operandi t)
  (run-at-time "07:00" (* 60 60 24) (lambda () (enable-theme 'modus-operandi))))


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

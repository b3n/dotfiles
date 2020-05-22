(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "Iosevka" :height 110))))
   '(fixed-pitch ((t (:family "Iosevka"))))
   '(variable-pitch ((t (:family "Libre Baskerville"))))))


(use-package face-remap
  :hook (text-mode . variable-pitch-mode)
  :custom
  (default-text-scale-amount 20))


(use-package olivetti
  :straight t
  :hook (text-mode . olivetti-mode)

  :custom
  (olivetti-body-width 80))


(use-package modus-vivendi-theme ;; Dark
  :straight t

  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t)
  (modus-vivendi-theme-section-headings t)
  (modus-vivendi-theme-distinct-org-blocks t)
  (modus-vivendi-theme-3d-modeline t)
  (modus-vivendi-theme-scale-5 1.9)

  :config
  (load-theme 'modus-vivendi t t)
  (run-at-time "19:00" (* 60 60 24) (lambda () (enable-theme 'modus-vivendi))))


(use-package modus-operandi-theme ;; Light
  :straight t

  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t)
  (modus-operandi-theme-section-headings t)
  (modus-operandi-theme-distinct-org-blocks t)
  (modus-operandi-theme-3d-modeline t)
  (modus-operandi-theme-scale-5 1.9)

  :config
  (load-theme 'modus-operandi t t)
  (run-at-time "07:00" (* 60 60 24) (lambda () (enable-theme 'modus-operandi))))


(use-package minions
  :straight t

  :custom
  (minions-mode-line-lighter "...")

  :config
  (minions-mode 1))


(use-package spaceline
  :straight t

  :custom
  (powerline-default-separator 'utf-8)
  (spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

  :config
  (require 'spaceline-config)
  (spaceline-toggle-version-control-off)
  (when (bound-and-true-p minions-mode)
    (spaceline-toggle-major-mode-off)
    (spaceline-define-segment minor-modes (format-mode-line minions-mode-line-modes)))
  (spaceline-emacs-theme))


(provide 'init-theme)

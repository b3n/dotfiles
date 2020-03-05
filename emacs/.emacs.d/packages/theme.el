(use-package doom-themes
  :disabled
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (load-theme 'doom-one-light t)
  (load-theme 'doom-one t))

(use-package modus-operandi-theme ;; Light
  :custom
  (modus-operandi-theme-slanted-constructs t)
  (modus-operandi-theme-bold-constructs t)
  (modus-operandi-theme-scale-headings t))

(use-package modus-vivendi-theme ;; Dark
  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t)

  :config
  (custom-theme-set-faces
   'modus-vivendi
   '(flyspell-duplicate ((t (:foreground "#ffffff" :inherit unspecified))))
   '(flyspell-incorrect ((t (:foreground "#ffffff" :inherit unspecified)))))

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

(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "JetBrains Mono" :height 110))))
   '(fixed-pitch ((t (:family "JetBrains Mono" :height 105))))
   '(variable-pitch ((t (:family "Libre Baskerville" :height 115))))))


(use-package face-remap
  :custom
  (default-text-scale-amount 20))


(use-package modus-themes
  :custom
  (modus-themes-bold-constructs t)
  (modus-themes-slanted-constructs t)
  (modus-themes-org-blocks 'greyscale)
  (modus-themes-syntax 'faint)
  (modus-themes-scale-5 1.8)
  (modus-themes-scale-headings t)
  (modus-themes-mode-line '3d)
  (modus-themes-completions 'opinionated)

  :config
  (modus-themes-load-themes)
  (run-at-time "05:00" (* 60 60 24) #'modus-themes-load-operandi)
  (run-at-time "19:00" (* 60 60 24) #'modus-themes-load-vivendi))


(use-package minibuffer-line
  :straight t

  :custom
  (minibuffer-line-format '(:eval mode-line-misc-info))
  (minibuffer-line-refresh-interval 1)

  :config
  (delete 'mode-line-misc-info mode-line-format)
  (minibuffer-line-mode t))


(provide 'init-theme)

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


(dolist (theme '("operandi" "vivendi"))
  (my/format-sexp
   (use-package modus-%1$s-theme
     :straight t

     :custom
     (modus-%1$s-theme-bold-constructs t)
     (modus-%1$s-theme-slanted-constructs t)
     (modus-%1$s-theme-distinct-org-blocks t)
     (modus-%1$s-theme-faint-syntax t)
     (modus-%1$s-theme-scale-5 1.9)
     (modus-%1$s-theme-scale-headings t)

     :config
     (load-theme 'modus-%1$s t t)
     (run-at-time
      (if (equal "%1$s" "operandi") "04:00" "19:00")
      (* 60 60 24)
      (lambda () (enable-theme 'modus-%1$s))))
   theme))


(use-package minibuffer-line
  :straight t

  :custom
  (minibuffer-line-format '(:eval mode-line-misc-info))
  (minibuffer-line-refresh-interval 1)

  :config
  (delete 'mode-line-misc-info mode-line-format)
  (minibuffer-line-mode t))


(provide 'init-theme)

(use-package default-text-scale
  :custom
  (default-text-scale-amount 25)

  :general (my-leader-def
             "z" '(:ignore z :which-key "Zoom")
             "z +" #'default-text-scale-increase
             "z -" #'default-text-scale-decrease
             "z 0" #'default-text-scale-reset
             "z b" #'text-scale-adjust))

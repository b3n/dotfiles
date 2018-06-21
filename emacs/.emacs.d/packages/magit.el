(use-package magit
  :diminish auto-revert-mode
  :general (my-leader-def
             "g" '(:ignore t :which-key "Git")
             "g s" #'magit-status
             "g b" #'magit-blame))

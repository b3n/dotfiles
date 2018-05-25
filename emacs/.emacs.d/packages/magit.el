(use-package magit
  :diminish auto-revert-mode
  :general (my-leader-def
             "g s" #'magit-status
             "g b" #'magit-blame))

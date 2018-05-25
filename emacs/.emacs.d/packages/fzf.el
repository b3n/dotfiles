(use-package fzf
  :ensure-system-package fzf
  :general (my-leader-def
             "f /" #'fzf
             "f ?" #'fzf-directory))

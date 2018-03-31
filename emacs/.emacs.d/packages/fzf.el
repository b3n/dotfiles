(use-package fzf
  :ensure-system-package fzf
  :general (:prefix my-prefix
		    "f /" #'fzf
		    "f ?" #'fzf-directory))

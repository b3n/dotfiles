(use-package magit
  :diminish auto-revert-mode
  :general (:prefix my-prefix
		    "g s" #'magit-status
		    "g b" #'magit-blame))

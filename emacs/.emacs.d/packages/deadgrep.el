(use-package deadgrep
  :general (my-leader-def "/" #'deadgrep)
  :ensure-system-package (rg . ripgrep))

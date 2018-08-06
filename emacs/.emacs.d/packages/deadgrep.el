(use-package deadgrep
  :general (my-leader-def "/" #'deadgrep)
  :ensure-system-package (rg . ripgrep)
  :config
  (evil-make-overriding-map deadgrep-mode-map 'normal))

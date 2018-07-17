(use-package deadgrep
  :general (my-leader-def
             "/" #'deadgrep)
  :config
  (evil-make-overriding-map deadgrep-mode-map 'normal))

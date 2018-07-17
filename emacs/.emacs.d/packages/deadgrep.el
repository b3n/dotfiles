(use-package deadgrep
  :general (my-leader-def
             "/" #'deadgrep)
  :config
  (evil-set-initial-state 'deadgrep-mode 'emacs))

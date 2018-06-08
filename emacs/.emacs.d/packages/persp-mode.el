(use-package persp-mode
  :general (my-leader-def
             "a" #'persp-add-buffer
             "b" #'persp-switch-to-buffer
             "k" #'persp-kill-buffer
             "p" #'persp-frame-switch)
  :diminish persp-mode
  :custom (persp-auto-resume-time -1)
  :config
  (persp-def-auto-persp "@irc" :mode 'erc-mode)
  (persp-mode))

(use-package persp-mode
  :general (my-leader-def
             "p a" #'persp-add-buffer
             "b" #'persp-switch-to-buffer
             "k" #'persp-kill-buffer
             "p l" #'persp-load-state-from-file
             "p p" #'persp-frame-switch)
  :diminish persp-mode
  :custom (persp-auto-resume-time -1)
  :config
  (persp-def-auto-persp "@irc" :mode 'erc-mode)
  (persp-mode))

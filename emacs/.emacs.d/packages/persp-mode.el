(use-package persp-mode
  :general (my-leader-def
             "b" #'persp-switch-to-buffer
             "k" #'persp-kill-buffer
             "p" '(:ignore t :which-key "Perspective")
             "p a" #'persp-add-buffer
             "p l" #'persp-load-state-from-file
             "p p" #'persp-frame-switch)
  :diminish persp-mode

  :custom
  (persp-auto-resume-time -1)
  (persp-emacsclient-init-frame-behaviour-override nil)

  :config
  (persp-def-auto-persp "@irc" :mode 'erc-mode)
  (persp-mode))

(use-package persp-mode
  :disabled
  :general (my-leader-def
             "b" #'persp-switch-to-buffer
             "k" #'persp-kill-buffer
             "p" '(:ignore t :which-key "Perspective")
             "p a" #'persp-add-buffer
             "p l" #'persp-load-state-from-file
             "p p" #'persp-frame-switch 
             "p <tab>" #'my-last-persp-switch)
  :diminish persp-mode

  :custom
  (persp-auto-resume-time -1)
  (persp-emacsclient-init-frame-behaviour-override nil)
  ;;(persp-init-frame-behaviour nil)

  :init
  (setq my-last-persp "none")
  (defun my-last-persp-switch ()
    "Switch to the previously selected perspective"
    (interactive)
    (persp-frame-switch my-last-persp))

  :config
  (add-hook 'persp-before-switch-functions
            (lambda (name frame) (setq my-last-persp persp-last-persp-name)))
  (persp-def-auto-persp "@irc" :mode 'erc-mode)
  (persp-mode))

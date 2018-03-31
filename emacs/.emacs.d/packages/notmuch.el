(use-package notmuch
  :disabled
  :config
  (autoload 'notmuch "notmuch" "notmuch mail" t)
  (setq message-kill-buffer-on-exit t))

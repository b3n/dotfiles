(use-package dashboard
  :disabled
  :init
  (setq inhibit-startup-message t)
  :config
  (setq dashboard-banner-logo-title (concat "\n" (shell-command-to-string "fortune")))
  (setq dashboard-startup-banner "~/.emacs.d/120px-EmacsIcon.svg.png")
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (agenda . 5)
                        (registers . 5)))
  (dashboard-setup-startup-hook))

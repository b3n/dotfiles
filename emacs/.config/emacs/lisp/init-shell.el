(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :straight t

  :config
  (exec-path-from-shell-initialize))


(use-package eshell
  :bind ("C-c e" . eshell)
  :hook (eshell-mode . with-editor-export-editor)

  :custom
  (eshell-hist-ignoredups t)
  (eshell-history-size 99999)
  (eshell-destroy-buffer-when-process-dies t)
  (eshell-scroll-to-bottom-on-output t)

  :config
  (setenv "PAGER" "")
  (setenv "ENV" "$HOME/.kshrc")
  (setenv "AUTOMAKE_VERSION" "1.16")
  (setenv "AUTOCONF_VERSION" "2.69")

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (switch-to-buffer (apply #'make-term (format "in-term %s %s" prog args) prog nil args))
    (term-mode))


  ;; Output the value of $? in eshell as well as the time taken by the previous command before printing $PS1.
  (defvar-local eshell-current-command-start-time nil)
  (defvar-local eshell-last-command-prompt nil)

  (defun eshell-current-command-start ()
    (setq eshell-current-command-start-time (current-time)))

  (defun eshell-current-command-stop ()
    (when eshell-current-command-start-time
      (setq eshell-last-command-prompt
            (format "(%i)(%.4fs)"
                    eshell-last-command-status
                    (float-time (time-subtract (current-time) eshell-current-command-start-time))))
      (setq eshell-current-command-start-time nil))
    (when eshell-last-command-prompt
      (eshell-interactive-print eshell-last-command-prompt)))

  (defun eshell-current-command-time-track ()
    (add-hook 'eshell-pre-command-hook #'eshell-current-command-start nil t)
    (add-hook 'eshell-post-command-hook #'eshell-current-command-stop nil t))

  (add-hook 'eshell-mode-hook #'eshell-current-command-time-track))


(provide 'init-shell)

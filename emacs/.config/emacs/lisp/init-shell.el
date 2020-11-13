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
  (eshell-history-size 9999)
  (eshell-destroy-buffer-when-process-dies t)
  (eshell-scroll-to-bottom-on-output t)
  (eshell-prompt-function
   (lambda ()
     (concat (abbreviate-file-name (eshell/pwd))
             (if (= (user-uid) 0) " #\n" " $\n"))))
  (eshell-prompt-regexp "^[^#$\n]* [#$]\n")
  
  :config
  (setenv "PAGER" "")
  (setenv "ENV" "$HOME/.kshrc")
  (setenv "AUTOMAKE_VERSION" "1.16")
  (setenv "AUTOCONF_VERSION" "2.69")

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (switch-to-buffer (apply #'make-term (format "in-term %s %s" prog args) prog nil args))
    (term-mode)))


(provide 'init-shell)

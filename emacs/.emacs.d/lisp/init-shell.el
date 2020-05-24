(use-package eshell
  :bind ("C-c e" . eshell)

  :custom
  (eshell-hist-ignoredups t)
  (eshell-history-size 9999)
  (eshell-destroy-buffer-when-process-dies t)
  (eshell-scroll-to-bottom-on-output t)
  
  :config
  (setenv "ENV" "$HOME/.kshrc")

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (switch-to-buffer (apply #'make-term (format "in-term %s %s" prog args) prog nil args))
    (term-mode)
    (term-char-mode)))


(use-package fish-completion
  :if (executable-find "fish")
  :straight t

  :config
  (add-to-list 'fish-completion--parent-commands "doas")
  (global-fish-completion-mode))


(provide 'init-shell)

(use-package eshell
  :custom
  (inhibit-read-only t)
  (eshell-hist-ignoredups t)
  (eshell-history-size 9999)
  
  :config
  (setenv "ENV" "$HOME/.kshrc")

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (switch-to-buffer (apply #'make-term (format "in-term %s %s" prog args) prog nil args))
    (term-mode)
    (term-char-mode)))


(use-package fish-completion
  :straight t

  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (add-to-list 'fish-completion--parent-commands "doas")
    (global-fish-completion-mode)))


(use-package esh-autosuggest
  :straight t
  :hook (eshell-mode . esh-autosuggest-mode))


(provide 'init-shell)

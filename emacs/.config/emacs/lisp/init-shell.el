(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :straight t

  :config
  (exec-path-from-shell-initialize))


(use-package eshell
  :bind ("C-c e" . eshell)

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

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (switch-to-buffer (apply #'make-term (format "in-term %s %s" prog args) prog nil args))
    (term-mode)
    (term-char-mode)))


(use-package fish-completion
  :disabled  ;; This creates a "~" directory inside my config...
  :if (executable-find "fish")
  :straight t

  :config
  (add-to-list 'fish-completion--parent-commands "doas")
  (global-fish-completion-mode))


(provide 'init-shell)

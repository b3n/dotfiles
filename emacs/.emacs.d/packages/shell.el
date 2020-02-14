(require 'eshell)

(my-leader-def
  "s" '((lambda () (interactive) (eshell 'N)) :which-key "Eshell"))

(setq inhibit-read-only t)
(setq eshell-hist-ignoredups t)
(setq eshell-history-size 9999)

(use-package fish-completion
  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (add-to-list 'fish-completion--parent-commands "doas")
    (global-fish-completion-mode)))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

(defun eshell/in-term (prog &rest args)
  "Run shell command in term buffer."
  (switch-to-buffer (apply #'make-term prog prog nil args))
  (term-mode)
  (term-char-mode))

(use-package exec-path-from-shell
  :commands (exec-path-from-shell-initialize))


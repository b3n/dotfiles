(require 'eshell)

(my-leader-def
  "s" '((lambda () (interactive) (eshell 'N)) :which-key "Eshell"))

(setq inhibit-read-only t)

(use-package fish-completion
  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (add-to-list 'fish-completion--parent-commands "doas")
    (global-fish-completion-mode)))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

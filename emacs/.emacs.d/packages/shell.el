(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)
;;(push "mpv" eshell-visual-commands)

(my-leader-def
  "s" '((lambda () (interactive) (eshell 'N)) :which-key "Eshell"))

(use-package fish-completion
  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (global-fish-completion-mode)))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

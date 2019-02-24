(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)
(push "mpv" eshell-visual-commands)

(use-package sane-term
  :init
  (my-leader-def
    "t" '(:ignore t :which-key "Terminal")
    "t e" '((lambda () (interactive) (eshell 'N)) :which-key "Eshell")
    "t c" #'shell-command)

  :general (my-leader-def
             "t t" #'sane-term
             "t n" #'sane-term-create))

(use-package fish-completion
  :config
  (when (and (executable-find "fish")
             (require 'fish-completion nil t))
    (global-fish-completion-mode)))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

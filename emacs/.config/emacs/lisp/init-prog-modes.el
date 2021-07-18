(use-package lsp-mode
  :straight t

  :bind-keymap ("C-c l" . lsp-command-map)

  :hook
  (sh-mode . lsp)
  (typescript-mode . lsp)

  :custom
  (lsp-pyls-plugins-pycodestyle-max-line-length 100)
  (lsp-pyls-plugins-flake8-max-line-length 100))


(use-package lsp-pyright
  :straight t

  :hook
  (python-mode . (lambda () (require 'lsp-pyright) (lsp))))


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'"


(use-package clojure-mode
  :straight t)


(use-package cider
  :straight t)


(use-package xml-mode
  :mode "\\.xlf\\'")


(provide 'init-prog-modes)

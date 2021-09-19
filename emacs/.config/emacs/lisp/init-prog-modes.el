(use-package lsp-mode
  :straight t
  :bind-keymap ("C-c l" . lsp-command-map)

  :hook
  (java-mode . lsp)
  (sh-mode . lsp)

  :custom
  (lsp-pyls-plugins-pycodestyle-max-line-length 100)
  (lsp-pyls-plugins-flake8-max-line-length 100))


(use-package lsp-pyright
  :straight t

  :hook
  (python-mode . (lambda () (require 'lsp-pyright) (lsp-deferred))))


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package clojure-mode
  :straight t
  :config
  (define-clojure-indent
    (defroutes 'defun)
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (HEAD 2)
    (ANY 2)
    (OPTIONS 2)
    (PATCH 2)
    (rfn 2)
    (let-routes 1)
    (context 2)))

(use-package flymake-kondor
  :straight t
  :hook (clojure-mode . flymake-kondor-setup))

(use-package cider
  :straight t)

(use-package ebnf-mode
  :mode "\\.bnf\\'"
  :straight t)


(provide 'init-prog-modes)

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))


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


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package lsp-java
  :straight t
  :config
  (add-hook 'java-mode-hook #'lsp))


(use-package dap-mode
  :straight t
  :bind (:map lsp-command-map ("d" . dap-hydra))

  :config
  (require 'dap-python)
  (dap-mode t)
  (dap-ui-mode t))


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel-mode
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'"
  :straight t)


(provide 'init-prog-modes)

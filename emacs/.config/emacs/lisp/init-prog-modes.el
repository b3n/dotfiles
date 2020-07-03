(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))


(use-package lsp-mode
  :straight t
  :bind-keymap ("C-c l" . lsp-command-map)

  :hook
  (python-mode . lsp) ;; pip install 'python-language-server[all]'
  (java-mode . lsp)
  (sh-mode . lsp)

  :custom
  (lsp-pyls-plugins-pycodestyle-max-line-length 100)
  (lsp-pyls-plugins-flake8-max-line-length 100))


(use-package lsp-ui
  :straight t
  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-update-mode 'point))


(use-package dap-mode
  :straight t
  :bind (:map lsp-command-map ("d" . dap-hydra))

  :config
  (require 'dap-python)
  (dap-mode t)
  (dap-ui-mode t))


(use-package lsp-java
  :straight t)


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel-mode
  :straight t)


(provide 'init-prog-modes)

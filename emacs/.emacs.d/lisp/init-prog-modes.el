(use-package lsp-mode
  :straight t
  :bind-keymap ("C-c l" . lsp-command-map)

  :hook
  (ruby-mode . lsp) ;; gem install solargraph
  (python-mode . lsp) ;; pip install 'python-language-server[all]'
  (java-mode . lsp))


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
  (dap-mode t)
  (dap-ui-mode t))


(use-package lsp-java
  :straight t)


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(provide 'init-prog-modes)

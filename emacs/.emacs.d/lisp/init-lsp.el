(use-package lsp-mode
  :general
  (my-leader "l" '(:keymap lsp-command-map :wk "LSP"))

  :hook
  (ruby-mode . lsp) ;; gem install solargraph
  (python-mode . lsp) ;; pip install 'python-language-server[all]'
  (java-mode . lsp))


(use-package lsp-ui
  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-update-mode 'point))


(use-package dap-mode
  :general
  (lsp-command-map "d" #'dap-hydra)

  :config
  (require 'dap-java)
  (dap-mode t)
  (dap-ui-mode t))


(use-package lsp-java)


(provide 'init-lsp)

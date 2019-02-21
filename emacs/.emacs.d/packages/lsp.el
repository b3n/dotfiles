(use-package lsp-mode
  :config
  (general-define-key :states 'normal "gd" #'xref-find-definitions))


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-update-mode 'point))


(use-package lsp-python
  :hook (python-mode . lsp-python-enable))


(use-package lsp-java
  :hook (java-mode . lsp-java-enable))

(use-package dap-mode
  :after (lsp-java)
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (require 'dap-java))

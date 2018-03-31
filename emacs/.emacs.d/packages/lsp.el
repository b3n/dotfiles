(use-package lsp-ui)


(use-package lsp-python
  :ensure-system-package pyls
  :hook (python-mode . lsp-python-enable))

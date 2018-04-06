(use-package lsp-mode)


(use-package lsp-ui
  :demand t
  :after (lsp-mode)
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil))


(use-package lsp-python
  :demand t
  ;;:ensure-system-package pyls
  :after (lsp-ui)
  :hook (python-mode . lsp-python-enable))

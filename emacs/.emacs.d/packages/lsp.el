(use-package lsp-mode
  :init
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))

  :hook
  (ruby-hook . lsp) ;; gem install solargraph

  :config
  (general-define-key :states 'normal "gd" #'xref-find-definitions)

  :commands lsp)


(use-package lsp-ui
  :disabled

  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-update-mode 'point))


(use-package dap-mode
  :disabled
  :config
  (dap-mode t)
  (dap-ui-mode t))

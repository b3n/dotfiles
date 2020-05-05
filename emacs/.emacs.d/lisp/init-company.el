(use-package company
  :disabled
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-lsp
  :disabled
  :config
  (add-to-list 'company-backends #'company-lsp))

(provide 'init-company)

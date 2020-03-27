(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-lsp
  :config
  (add-to-list 'company-backends #'company-lsp))

(provide 'init-company)

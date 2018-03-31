(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-jedi
  :after '(company)
  :config
  (add-to-list 'company-backends 'company-jedi))

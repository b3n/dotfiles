(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-jedi
  :config
  (add-to-list 'company-backends #'company-jedi))

(use-package company-lsp
  :config
  (add-to-list 'company-backends #'company-lsp))

(use-package company-tabnine
  :disabled
  :config
  (add-to-list 'company-backends #'company-tabnine)
  (setq company-idle-delay 0)
  (setq company-show-numbers t))

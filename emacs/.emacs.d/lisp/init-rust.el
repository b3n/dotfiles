(use-package rust-mode
  :straight t

  :config
  (setq rust-format-on-save t))

(use-package cargo
  :disabled
  :straight t)

(use-package racer
  :disabled
  :straight t
  :after company
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (require 'rust-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))


(provide 'init-rust)

(use-package pdf-tools
  :straight t

  :custom
  (pdf-view-display-size 'fit-height)

  :config
  (pdf-loader-install))


(use-package pdf-view-restore
  :straight t
  :after pdf-tools

  :custom
  (pdf-view-restore-filename (expand-file-name "pdf-view-restore" user-emacs-directory))

  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))


(provide 'init-pdf)

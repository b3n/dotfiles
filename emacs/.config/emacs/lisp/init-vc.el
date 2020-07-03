(use-package vc-hooks
  :custom
  (vc-follow-symlinks t)

  :config
  (delete '(vc-mode vc-mode) mode-line-format)
  (nconc mode-line-format '((vc-mode vc-mode))))


(use-package magit
  :straight t
  :bind (("C-c g" . magit-status)
         :map magit-mode-map
         ("C-w"))
  :custom
  (magit-save-repository-buffers 'dontask)
  (magit-no-confirm '(stage-all-changes)))


(provide 'init-vc)

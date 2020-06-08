(use-package vc-hooks
  :custom
  (vc-follow-symlinks t))


(use-package magit
  :straight t
  :bind (("C-c g" . magit-status)
         :map magit-mode-map
         ("C-w")))


(provide 'init-vc)

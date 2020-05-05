(use-package vc-hooks
  :straight nil

  :custom
  (vc-follow-symlinks t))


(use-package magit
  :general (my-leader "g" #'magit-status))


(provide 'init-vc)

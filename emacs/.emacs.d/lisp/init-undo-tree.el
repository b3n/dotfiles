(use-package undo-tree
  :general (my-leader "U" #'undo-tree-visualize)
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (global-undo-tree-mode))


(provide 'init-undo-tree)

(use-package undo-tree
  :straight t

  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

  :config
  (global-undo-tree-mode))


(provide 'init-undo-tree)

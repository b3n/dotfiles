(use-package undo-tree
  :demand
  :straight t
  :bind ("C-c u" . undo-tree-visualize)

  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

  :config
  (global-undo-tree-mode))


(provide 'init-undo-tree)

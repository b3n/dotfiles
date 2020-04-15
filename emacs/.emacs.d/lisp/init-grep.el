(use-package project
  :straight nil
  :bind ("s-f" . project-find-file))


(use-package wgrep)


(use-package rg
  :bind ("s-/" . rg-project))


(provide 'init-grep)

(use-package project
  :straight nil
  :general (my-leader "f p" #'project-find-file))


(use-package wgrep)


(use-package rg
  :general (my-leader "/" #'rg-project))


(provide 'init-grep)

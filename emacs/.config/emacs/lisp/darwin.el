;; Work (OS X)


(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "Monaco" :height 145))))
   '(fixed-pitch ((t (:family "Monaco"))))
   '(variable-pitch ((t (:family "Baskerville" :height 195))))))


(use-package company
  :straight t
  :config
  (global-company-mode))


(use-package typescript-mode
  :straight t
  :custom
  (typescript-indent-level 2))


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel-mode
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'"
  :straight t)


(use-package lsp-java
  :straight t)


(provide 'darwin)

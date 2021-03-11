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


(provide 'darwin)

(use-package eldoc
  :custom
  (eldoc-echo-area-use-multiline-p nil))


(use-package eglot
  :straight t

  :hook
  (java-mode . eglot-ensure)
  (clojure-mode . eglot-ensure)
  (clojurescript-mode . eglot-ensure)
  (clojurec-mode . eglot-ensure)
  (python-mode . elgot-ensure)

  :custom
  (eglot-autoshutdown t))


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'")


(use-package clojure-mode
  :straight t)

(use-package flymake-kondor
  :straight t
  :hook (clojure-mode . flymake-kondor-setup))

(use-package cider
  :straight t)


(use-package ebnf-mode
  :mode "\\.bnf\\'"
  :straight t)


(use-package xml-mode
  :mode "\\.xlf\\'")


(provide 'init-prog-modes)

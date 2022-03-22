(use-package eglot
  :straight t

  :init
  ;; Get latest versions, for older Emacs
  (use-package eldoc :straight t)
  (use-package flymake :straight t)
  (use-package project :straight t)
  (use-package xref :straight t)

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
  :mode "\\.tsx\\'"


(use-package clojure-mode
  :straight t
  :config
  (define-clojure-indent
    (defroutes 'defun)
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (HEAD 2)
    (ANY 2)
    (OPTIONS 2)
    (PATCH 2)
    (rfn 2)
    (let-routes 1)
    (context 2)))

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

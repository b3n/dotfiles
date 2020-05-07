(use-package flycheck
  :disabled
  :straight t
  :hook (prog-mode . flycheck-mode)

  :custom
  (flycheck-flake8-maximum-line-length 100)
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc)))


(use-package flymake
  :hook (prog-mode . flymake-mode)

  :custom
  (flymake-no-changes-timeout nil)
  (flymake-wrap-around nil))


(provide 'init-flycheck)

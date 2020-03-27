(use-package flycheck
  :hook (prog-mode-hook . flycheck-mode)
  :custom
  (flycheck-flake8-maximum-line-length 100)
  :init
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc)))


(provide 'init-flycheck)

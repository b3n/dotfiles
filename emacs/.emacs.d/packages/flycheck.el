(use-package flycheck
  :hook ((emacs-lisp-mode . flycheck-mode)
	 (python-mode . flycheck-mode))
  :custom
  (flycheck-flake8-maximum-line-length 100)
  :init
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

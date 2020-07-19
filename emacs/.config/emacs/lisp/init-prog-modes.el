(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))


(use-package lsp-mode
  :straight t
  :bind-keymap ("C-c l" . lsp-command-map)

  :hook
  ;; (python-mode . lsp) ;; pip install 'python-language-server[all]'
  (java-mode . lsp)
  (sh-mode . lsp)

  :custom
  (lsp-pyls-plugins-pycodestyle-max-line-length 100)
  (lsp-pyls-plugins-flake8-max-line-length 100))


(use-package lsp-python-ms
  :if (eq system-type 'darwin)
  :straight t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp-deferred))))


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package lsp-java
  :straight t)


(use-package dap-mode
  :straight t
  :bind (:map lsp-command-map ("d" . dap-hydra))

  :config
  (require 'dap-python)
  (dap-mode t)
  (dap-ui-mode t))


(use-package json-mode
  :mode "\\.json\\'"
  :straight t)


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel-mode
  :straight t)


(provide 'init-prog-modes)

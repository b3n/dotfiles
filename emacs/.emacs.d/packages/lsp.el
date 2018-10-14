(use-package lsp-mode
  :config
  (general-define-key :states 'normal "gd" #'xref-find-definitions))


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)

  :custom
  (lsp-ui-doc nil t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable nil)
  (lsp-ui-peek-enable nil)
  (lsp-ui-sideline nil t)
  (lsp-ui-sideline-enable nil))


(use-package lsp-python
  :after (lsp-mode)
  :hook (python-mode . lsp-python-enable)

  :config
  ;; Replace with my own traverser for now, as the current one is buggy.
  (setq my-project-root-files '("README.md" "setup.py" ".git" "requirements.txt"))
  (lsp-define-stdio-client lsp-python "python"
			               (lsp-make-traverser
			                #'(lambda (dir)
				                (directory-files
				                 dir
				                 nil
				                 (mapconcat #'regexp-quote my-project-root-files "\\|"))))
			               '("pyls")))


(use-package dap-mode
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (require 'dap-java))

(use-package lsp-java
  :hook (java-mode . lsp-java-enable)

  :config
  (setq lsp-ui-sideline-update-mode 'point))

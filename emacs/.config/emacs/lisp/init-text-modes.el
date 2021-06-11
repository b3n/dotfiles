(use-package olivetti
  :straight t
  :hook ((org-mode . olivetti-mode)
         (markdown-mode . olivetti-mode)
         (olivetti-mode . variable-pitch-mode))

  :custom
  (olivetti-body-width 99))


(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :straight t)


(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode)
  :straight t)


(use-package tex
  :init
  (setq doc-view-continuous t)

  :defer t
  :straight auctex

  :custom
  (latex-run-command "pdflatex")
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-save-query nil)
  (TeX-PDF-mode t)
  (TeX-view-program-selection '((output-pdf "PDF Tools"))
                              TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
                              TeX-source-correlate-start-server t)
  :config
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))


(use-package csv-mode
  :mode "\\.csv\\'"
  :straight t)


(use-package yaml-mode
  :mode "\\.ya?ml\\(\\.j2\\)?\\'"
  :straight t)


(provide 'init-text-modes)

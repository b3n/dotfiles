(use-package tex
  :straight auctex
  :commands TeX-mode

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
  (setq doc-view-continuous t)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(provide 'init-auctex)

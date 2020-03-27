(use-package json-mode)


(use-package jq-mode
  :disabled
  :after (json-mode)

  :config
  (define-key json-mode-map (kbd "C-c C-j") #'jq-interactively))


(provide 'init-json)

(use-package json-mode)


(use-package jq-mode
  :after (json-mode)
  :ensure-system-package jq

  :config
  (define-key json-mode-map (kbd "C-c C-j") #'jq-interactively))

(use-package avy
  :custom
  (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a))

  :config
  (evil-define-key '(normal visual) 'global
    "s" #'avy-goto-char
    "S" #'avy-pop-mark))

(provide 'init-avy)

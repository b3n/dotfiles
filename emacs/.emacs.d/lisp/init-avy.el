(use-package avy
  :custom
  (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a))

  :general
  (general-define-key
   :states '(normal motion)
   "<backspace>" #'avy-goto-word-or-subword-1))


(use-package link-hint
  :general
  (general-define-key
   :states '(normal motion)
   "<C-backspace>" #'link-hint-open-link))


(provide 'init-avy)

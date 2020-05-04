(use-package avy
  :custom
  (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a))

  :general
  (general-define-key
   :states '(normal motion)
   "x" #'avy-goto-word-or-subword-1))


(use-package link-hint
  :general
  (general-define-key
   :states '(normal motion)
   "X" #'link-hint-open-link))


(provide 'init-avy)

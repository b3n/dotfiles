(use-package avy
  :general (my-leader-def "a" #'avy-goto-char)
  :custom
  (avy-keys '(?a ?r ?s ?t ?d ?h ?n ?e ?i ?o))
  :config
  (avy-setup-default))

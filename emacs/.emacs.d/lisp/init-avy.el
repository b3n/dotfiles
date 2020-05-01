(use-package avy
  :custom
  (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a))

  :general
  (my-leader
    "j" '(:ignore t :wk "Jump")
    "j b" #'avy-pop-mark
    "j j" #'avy-goto-char
    "j J" #'avy-goto-char-2
    "j l" #'avy-goto-line
    "j w" #'avy-goto-word-or-subword-1))


(use-package link-hint
  :general
  (my-leader "j o" #'link-hint-open-link))


(provide 'init-avy)

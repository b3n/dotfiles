(use-package sane-term
  :init
  (my-leader-def
    "t" '(:ignore t :which-key "Terminal")
    "t e" '((lambda () (interactive) (eshell 'N)) :which-key "Eshell")
    "t c" #'shell-command)

  :general (my-leader-def
             "t t" #'sane-term
             "t n" #'sane-term-create))

(use-package winner
  :general (:prefix my-prefix
		    "u" #'winner-undo
		    "C-r" #'winner-redo)
  :config (winner-mode 1))

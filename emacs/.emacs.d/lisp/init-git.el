(use-package magit
  :init
  (delete 'Git vc-handled-backends)
  :diminish auto-revert-mode
  :general (my-leader-def
             "g" '(:ignore t :which-key "Git")
             "g s" #'magit-status
             "g b" #'magit-blame-addition))


(provide 'init-git)

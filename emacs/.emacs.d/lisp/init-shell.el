(use-package shell
  :straight nil
  :general (my-leader "s" #'shell)
  :config
  (setenv "ENV" "$HOME/.kshrc"))


(provide 'init-shell)

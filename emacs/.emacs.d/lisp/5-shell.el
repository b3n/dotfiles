(use-package shell
  :straight f
  :bind ("C-c s" . shell)
  :config
  (setenv "ENV" "$HOME/.kshrc"))

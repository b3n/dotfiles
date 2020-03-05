(use-package shell
  :ensure f
  :bind ("C-c s" . shell)
  :config
  (setenv "ENV" "$HOME/.kshrc"))

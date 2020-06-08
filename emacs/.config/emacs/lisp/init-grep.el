(use-package rg
  :straight t

  :custom
  (rg-default-alias-fallback "everything")

  :config
  (rg-enable-default-bindings)

  (rg-define-search search-everything-at-home
    "Search files including hidden in home directory"
    :query ask
    :format literal
    :files "everything"
    :flags ("--hidden")
    :dir (getenv "HOME")
    :menu ("Search" "h" "Home")))


(provide 'init-grep)

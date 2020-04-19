(use-package tab-bar
  :straight nil
  :bind ("s-0" . tab-bar-switch-to-recent-tab)

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(super))
  (tab-bar-tab-hints t))

(provide 'init-tab-bar)

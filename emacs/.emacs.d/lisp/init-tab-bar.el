(use-package tab-bar
  :straight nil
  ;;:general ("M-0" #'tab-bar-switch-to-recent-tab)
  :general (:keymaps 'tab-prefix-map
                     "q" #'tab-close
                     "u" #'tab-undo
                     "t" #'tab-new)

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(meta))
  (tab-bar-tab-hints t))


(provide 'init-tab-bar)

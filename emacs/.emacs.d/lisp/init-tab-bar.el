(use-package tab-bar
  :straight nil
  :general (:keymaps 'tab-prefix-map
                     "q" #'tab-close
                     "u" #'tab-undo
                     "t" #'tab-new)

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(meta))
  (tab-bar-tab-hints t)
  (tab-bar-new-button nil)
  (tab-bar-close-button nil)
  (tab-bar-show "1"))


(provide 'init-tab-bar)

(use-package tab-bar
  :bind (:map tab-prefix-map
              ("q" . tab-close)
              ("u" . tab-undo)
              ("t" . tab-new))

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-select-tab-modifiers '(super))
  (tab-bar-tab-hints t)
  (tab-bar-close-button nil))


(provide 'init-tab-bar)

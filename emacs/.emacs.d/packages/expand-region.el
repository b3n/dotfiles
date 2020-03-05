(use-package expand-region
  :bind (:map evil-normal-state-map
              ("<SPC>" . er/expand-region)
              ("S-<SPC>" . er/contract-region)
              :map evil-visual-state-map
              ("<SPC>" . er/expand-region)
              ("S-<SPC>" . er/contract-region)))

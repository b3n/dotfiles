(use-package winum
  :bind (:map evil-window-map
              ("1" . winum-select-window-1)
              ("2" . winum-select-window-2)
              ("3" . winum-select-window-3)
              ("4" . winum-select-window-4)
              ("5" . winum-select-window-5)
              ("6" . winum-select-window-6)
              ("7" . winum-select-window-7)
              ("8" . winum-select-window-8)
              ("9" . winum-select-window-9)
              ("0" . winum-select-window-0))

  :config
  (winum-mode))

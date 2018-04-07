(use-package spaceline
  :config
  (require 'spaceline-config)
  (setq spaceline-window-numbers-unicode t)
  (setq evil-echo-state nil
        spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-spacemacs-theme)
  (spaceline-toggle-version-control-off))

(use-package spaceline
  :config
  (require 'spaceline-config)
  (setq spaceline-window-numbers-unicode t)
  (setq evil-echo-state nil
        spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-toggle-version-control-off)
  (spaceline-spacemacs-theme))


(use-package spaceline-all-the-icons 
  :after (spaceline all-the-icons)

  :config
  (spaceline-all-the-icons-theme))

(use-package savehist
  :straight nil

  :custom
  (history-length 9999)

  :config
  (savehist-mode 1))


(use-package rfn-eshadow
  :straight nil

  :config
  (file-name-shadow-mode 1))


(use-package minibuffer
  :straight nil
  :demand
  :bind (:map completion-list-mode-map
              ("j" . next-line)
              ("k" . previous-line)
              ("n" . next-completion)
              ("p" . previous-completion))

  :custom
  (completion-styles '(partial-completion flex))
  (completion-category-overrides '((file (styles basic initials))))
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)

  :config
  (minibuffer-electric-default-mode 1))


(use-package icomplete
  :straight nil
  :demand
  :after minibuffer

  :bind (:map icomplete-minibuffer-map
              ("<right>" . icomplete-forward-completions)
              ("<left>" . icomplete-backward-completions)
              ("DEL" . icomplete-fido-backward-updir)
              ("<return>" . icomplete-fido-ret)
              ("M-<return>" . icomplete-fido-exit)
              ("s-<return>" . minibuffer-complete-and-exit))

  :custom
  (icomplete-hide-common-prefix nil)
  (icomplete-prospects-height 1)
  (icomplete-separator " · ")
  (icomplete-show-matches-on-no-input t)
  (icomplete-tidy-shadowed-file-names t)

  :config
  (icomplete-mode))


(provide 'init-icomplete)

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

  :custom
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)

  :config
  (minibuffer-electric-default-mode 1))


(use-package icomplete
  :straight nil
  :demand
  :after minibuffer

  :general (:keymaps 'icomplete-minibuffer-map
                     "<down>" #'icomplete-forward-completions
                     "<up>" #'icomplete-backward-completions
                     "DEL" #'icomplete-fido-backward-updir
                     "<return>" #'icomplete-fido-ret
                     "M-<return>" #'icomplete-fido-exit
                     "s-<return>" #'minibuffer-complete-and-exit)

  :custom
  (icomplete-hide-common-prefix nil)
  (icomplete-prospects-height 1)
  (icomplete-separator " · ")
  (icomplete-show-matches-on-no-input t)
  (icomplete-tidy-shadowed-file-names t)

  :config
  (icomplete-mode))


(use-package orderless
  :after minibuffer
  :custom (completion-styles '(orderless)))


(provide 'init-icomplete)

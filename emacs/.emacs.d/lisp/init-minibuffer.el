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

  :general
  (minibuffer-local-completion-map
   "S-<return>" #'minibuffer-complete-and-exit)

  :custom
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(substring partial-completion flex))
  (enable-recursive-minibuffers t)

  :config
  (minibuffer-electric-default-mode 1))


(use-package icomplete
  :straight nil
  :demand

  :general
  (icomplete-minibuffer-map
   "<right>" #'icomplete-forward-completions
   "<left>" #'icomplete-backward-completions
   "DEL" #'icomplete-fido-backward-updir
   "<return>" #'icomplete-fido-ret
   "M-<return>" #'icomplete-fido-exit)

  :custom
  (icomplete-prospects-height 1)
  (icomplete-separator "  ")
  (icomplete-show-matches-on-no-input t)
  (icomplete-tidy-shadowed-file-names t)

  :config
  (icomplete-mode))


(use-package restricto
  :after minibuffer
  :straight (:host github :repo "oantolin/restricto")

  :general
  (minibuffer-local-completion-map
   "SPC" #'restricto-narrow
   "S-SPC" #'restricto-widen)

  :config
  (restricto-mode))


;; This is just to fix a bug with long strings where it tries to put them in two columns
(use-package live-completions
  :disabled
  :after minibuffer
  :straight (:host github :repo "oantolin/live-completions")

  :config
  (live-completions-set-columns 'single))


(use-package icomplete-vertical
  :disabled ; This is a buggy mode
  :after icomplete

  :general
  (icomplete-minibuffer-map
   "<down>" #'icomplete-forward-completions
   "<up>" #'icomplete-backward-completions
   "C-v" #'icomplete-vertical-toggle)

  :config
  (icomplete-vertical-mode))


(provide 'init-minibuffer)

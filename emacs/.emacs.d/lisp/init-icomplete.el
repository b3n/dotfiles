(use-package savehist
  :straight nil

  :custom
  (history-length 99999)

  :config
  (savehist-mode 1))


(use-package rfn-eshadow
  :straight nil

  :config
  (file-name-shadow-mode 1))


(use-package minibuffer
  :straight nil
  :demand

  :custom
  (completion-styles '(partial-completion substring))
  (completion-category-overrides
   '((file (styles basic substring))
     (buffer (styles basic substring))
     (info-menu (styles basic))))
  (completions-format 'vertical)
  (enable-recursive-minibuffers t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)

  :config
  (minibuffer-depth-indicate-mode 1)
  (minibuffer-electric-default-mode 1)

  :bind (:map completion-list-mode-map
              ("j" . next-line)
              ("k" . previous-line)
              ("n" . next-completion)
              ("p" . previous-completion)))


(use-package icomplete
  :straight nil
  :demand
  :after minibuffer

  :bind (:map icomplete-minibuffer-map
              ("DEL" . icomplete-fido-backward-updir)
              ("M-<return>" . minibuffer-force-complete-and-exit)
              ("s-<return>" . minibuffer-complete-and-exit))

  :custom
  (icomplete-show-matches-on-no-input t)

  :config
  (icomplete-mode 1))


(provide 'init-icomplete)

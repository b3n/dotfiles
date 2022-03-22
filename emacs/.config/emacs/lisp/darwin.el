;; Work (OS X) config


(use-package emacs
  :custom
  (tab-width 2))


(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "Monaco" :height 145))))
   '(fixed-pitch ((t (:family "Monaco"))))
   '(variable-pitch ((t (:family "Baskerville" :height 195))))))


(use-package lsp-mode
  :custom
  (lsp-enable-file-watchers nil)) ;; Because monorepo, hopefully this helps with "too many open files"


(use-package company
  ;; TODO: Why am I even using this?
  :straight t
  :config
  (global-company-mode))


(use-package js
  :custom
  (js-indent-level 2))


(use-package typescript-mode
  :straight t
  :custom
  (typescript-indent-level 2))


(use-package sh-script
  :custom
  (sh-basic-offset 2))


(use-package magit
  :config
  ;; Monorepo makes git slow, so do less on magit refresh
  (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))


(use-package vterm
  :straight t
  :bind ("C-c v" . vterm)

  :custom
  (vterm-max-scrollback 100000)
  (vterm-buffer-name-string "vterm<%s>")

  :config
  (define-key vterm-mode-map (kbd "<C-escape>")
    (lambda () (interactive) (vterm-send-key (kbd "C-[")))))


(use-package blacken
  :straight t

  :hook
  (python-mode . blacken-mode) ;; brew install black

  :custom
  (blacken-line-length 100))


(use-package terraform-mode
  :mode "\\.tf\\'"
  :straight t)


(use-package bazel-mode
  :straight t)


(use-package web-mode
  :mode "\\.tsx\\'"
  :straight t)


(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode)
  :straight t)


(use-package yaml-mode
  :mode "\\.ya?ml\\(\\.j2\\)?\\'"
  :straight t)


(provide 'darwin)

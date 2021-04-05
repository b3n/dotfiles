;; Work (OS X) config


(use-package cus-face
  :config
  (custom-set-faces
   '(default ((t (:family "Monaco" :height 145))))
   '(fixed-pitch ((t (:family "Monaco"))))
   '(variable-pitch ((t (:family "Baskerville" :height 195))))))


(use-package company
  :straight t
  :config
  (global-company-mode))


(use-package typescript-mode
  :straight t
  :custom
  (typescript-indent-level 2))


(use-package sh-script
  :custom
  (sh-basic-offset 2))


(use-package magit
  :config
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


(provide 'darwin)

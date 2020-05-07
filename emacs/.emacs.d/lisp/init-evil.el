(use-package evil
  :straight t

  :init
  (setq evil-want-keybinding nil) ;; We use evil-collection for this

  :custom
  (evil-search-module 'evil-search)
  (evil-shift-round nil)
  (evil-symbol-word-search t)
  (evil-want-minibuffer t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-C-w-delete nil)

  :config
  (general-def evil-window-map
    "f" #'other-frame
    "Q" #'evil-delete-buffer)
  (general-unbind evil-motion-state-map "<up>" "<down>" "RET" "SPC")
  ;; (evil-set-initial-state 'completion-list-mode 'normal)

  (evil-mode 1))


(use-package evil-collection
  :straight t
  :config
  (evil-collection-init))


(use-package evil-surround
  :straight t
  :general
  (general-define-key :states '(normal operator) "s" #'evil-surround-edit)
  (general-define-key :states 'visual "s" #'evil-surround-region))


(use-package evil-org
  :after org

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (evil-org-set-key-theme '(navigation)))


(use-package evil-magit
  :straight t)


(use-package evil-anzu
  :straight t
  :config
  (global-anzu-mode +1))


(use-package evil-commentary
  :straight t
  :config
  (evil-commentary-mode))


(use-package winner
  :after evil

  :general
  (general-def evil-window-map
    "u" #'winner-undo
    "C-r" #'winner-redo)

  :config
  (winner-mode 1))


(use-package evil-indent-plus
  :straight t
  :general
  (evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent))


(provide 'init-evil)

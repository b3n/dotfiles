(use-package evil
  :init
  (winner-mode 1) ; TODO: Move where it belongs
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  :custom
  (evil-search-module 'evil-search)
  (evil-shift-round nil)
  (evil-symbol-word-search t)
  (evil-want-minibuffer t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-C-w-delete nil)

  :config
  (my-leader
    "w" '(:keymap evil-window-map :wk "Window"))
  (general-def evil-window-map
    "f" #'other-frame
    "Q" #'evil-delete-buffer
    "t" '(:keymap tab-prefix-map :wk "Tab bar")
    "u" #'winner-undo
    "C-r" #'winner-redo)
  (general-unbind evil-motion-state-map "<up>" "<down>" "RET" "SPC")

  (evil-mode 1))


(use-package evil-collection
  :config
  (evil-collection-init))


(use-package evil-surround
  :general
  (general-define-key :states '(normal operator) "s" 'evil-surround-edit)
  (general-define-key :states 'visual "s" 'evil-surround-region))


(use-package evil-org ; TODO: Test if I need this
  :after org

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit) ; TODO: Test if I need this


(use-package evil-anzu
  :config
  (global-anzu-mode +1))


(use-package repeat
  :straight nil
  :general (my-leader "." #'repeat))


(provide 'init-evil)

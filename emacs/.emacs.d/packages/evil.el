(use-package evil
  :init
  (winner-mode 1)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)

  :custom
  (evil-shift-round nil)
  (evil-symbol-word-search t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-C-w-delete nil)

  :config
  (define-key evil-motion-state-map (kbd "RET") nil)
  (general-define-key :keymaps 'evil-window-map
                      "u" #'winner-undo
                      "C-r" #'winner-redo
                      "f" #'other-frame
                      "d" #'evil-delete-buffer)
  (evil-mode 1))


(use-package evil-collection
  :after evil
  :config (evil-collection-init))


(use-package evil-surround
  :after (evil)

  :config
  (global-evil-surround-mode 1))


(use-package evil-org
  :after (evil org)
  :diminish evil-org-mode

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit
  :after (evil magit))


(use-package evil-anzu
  :after (evil)
  :config (global-anzu-mode +1))

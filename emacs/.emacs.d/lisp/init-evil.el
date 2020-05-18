(use-package evil
  :demand
  :straight t
  :bind (:map evil-window-map
         ("C-f" . other-frame)
         :map evil-motion-state-map
         ("<up>") ("<down>") ("RET") ("SPC"))

  :custom
  (evil-disable-insert-state-bindings t)
  (evil-symbol-word-search t)
  (evil-want-C-w-delete nil)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  ;; This is needed because we disable other insert state bindings, but want
  ;; C-w everywhere.
  :bind-keymap ("C-w" . evil-window-map)

  :config
  (setq evil-insert-state-modes (append evil-insert-state-modes evil-emacs-state-modes))
  (setq evil-emacs-state-modes nil)

  ;; (add-to-list 'evil-motion-state-modes 'dired-mode)
  (add-to-list 'evil-insert-state-modes 'git-commit-mode)

  (evil-mode 1))


(use-package evil-surround
  :straight t
  :config
  (evil-define-key '(normal operator) global-map "s" 'evil-surround-edit)
  (evil-define-key 'visual global-map "s" 'evil-surround-region))


(use-package evil-commentary
  :straight t
  :config
  (evil-commentary-mode))


(use-package winner
  :after evil

  :bind (:map evil-window-map
    ("u"   . winner-undo)
    ("C-u" . winner-undo)
    ("C-r" . winner-redo))

  :config
  (winner-mode 1))


(use-package evil-indent-plus
  :straight t
  :bind (:map evil-inner-text-objects-map
              ("i" . evil-indent-plus-i-indent)
         :map evil-outer-text-objects-map
              ("i" . evil-indent-plus-a-inednt)))


(provide 'init-evil)

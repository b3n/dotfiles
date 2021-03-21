(use-package evil
  :ensure
  :straight t

  :init
  (setq evil-undo-system 'undo-redo)
  (setq evil-intercept-maps nil)
  (setq evil-overriding-maps nil)
  (setq evil-want-keybinding nil)
  (setq qevil-disable-insert-state-bindings t)
  (setq qevil-normal-state-modes '(prog-mode text-mode))
  (setq qevil-insert-state-modes '(special-mode))

  :bind (:map evil-window-map
         ("C-f" . other-frame)
         :map evil-motion-state-map
         ("<up>") ("<down>") ("RET")
         :map evil-normal-state-map
         ("q") ;; TODO: Only set q to nil if it would have overriden something else (like quit)
         :map evil-visual-state-map
         ("v" . evil-visual-line))

  :custom
  (evil-mode-line-format 'after)
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  :config
  (evil-mode 1)

  ;; This is needed because we disable evil insert state bindings, but still want C-w.
  (evil-global-set-key 'insert (kbd "C-w") 'evil-window-map))


(use-package evil-surround
  ;; TODO: Setup better bindings (e.g. use `s` instead of `ys`)
  :after evil
  :straight t

  :config
  (global-evil-surround-mode 1))


;; Great for Python
(use-package evil-indent-plus
  :after evil
  :straight t
  :bind (:map evil-inner-text-objects-map
              ("i" . evil-indent-plus-i-indent)
         :map evil-outer-text-objects-map
              ("i" . evil-indent-plus-a-indent)))


;; Great for HTML
(use-package evil-matchit
  :straight t

  :config
  (global-evil-matchit-mode 1))


(use-package winner
  :after evil
  :demand
  :bind (:map evil-window-map
    ("u"   . winner-undo)
    ("C-u" . winner-undo)
    ("C-r" . winner-redo))

  :config
  (winner-mode 1))


(provide 'init-evil)

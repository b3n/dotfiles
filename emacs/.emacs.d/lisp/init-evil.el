(use-package evil
  :demand
  :straight t
  :bind (:map evil-window-map
         ("C-f" . other-frame)
         :map evil-motion-state-map
         ("<up>") ("<down>") ("RET")
         ("i" . evil-insert))

  :custom
  (evil-default-state 'insert)
  (evil-disable-insert-state-bindings t)
  (evil-emacs-state-modes nil)
  (evil-lookup-func (lambda () (call-interactively #'man))) ; Woman doesn't work on OpenBSD :-(
  (evil-normal-state-modes '(prog-mode text-mode))
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-want-C-w-delete nil)
  (evil-want-Y-yank-to-eol t)
  (evil-want-keybinding nil)
  (evil-want-minibuffer t)

  ;; This is needed because we disable other evil insert state bindings, but
  ;; still want C-w everywhere.
  :bind-keymap ("C-w" . evil-window-map)

  :config
  (evil-mode 1)

  ;; Get rid of undo-tree
  (with-eval-after-load 'undo-tree
    (global-set-key [remap undo-tree-undo] #'undo-only)
    (global-set-key [remap undo-tree-redo] #'undo-redo)
    (global-undo-tree-mode -1))
  (evil-define-key '(normal visual) global-map
    "U" #'undo
    "u" #'undo-only
    (kbd "C-r") #'undo-redo))


(use-package evil-surround
  :straight t
  :config
  (global-evil-surround-mode 1))


(use-package evil-indent-plus
  :after evil
  :straight t
  :bind (:map evil-inner-text-objects-map
              ("i" . evil-indent-plus-i-indent)
         :map evil-outer-text-objects-map
              ("i" . evil-indent-plus-a-indent)))


(use-package winner
  :after evil
  :bind (:map evil-window-map
    ("u"   . winner-undo)
    ("C-u" . winner-undo)
    ("C-r" . winner-redo))

  :config
  (winner-mode 1))


(provide 'init-evil)

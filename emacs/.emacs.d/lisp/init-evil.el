(use-package evil
  :init
  (setq evil-want-keybinding nil)
  
  :demand
  :straight t
  :bind (:map evil-window-map
         ("C-f" . other-frame)
         :map evil-motion-state-map
         ("<up>") ("<down>") ("RET")
         ("i" . evil-insert))

  :custom
  (evil-disable-insert-state-bindings t)
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-want-C-w-delete nil)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  ;; This is needed because we disable other insert state bindings, but still
  ;; want C-w everywhere.
  :bind-keymap ("C-w" . evil-window-map)

  :config
  ;; I'll just use insert state instead of emacs state.
  (setq evil-insert-state-modes (append evil-insert-state-modes evil-emacs-state-modes '(git-commit-mode)))
  (setq evil-emacs-state-modes nil)
  (add-to-list 'evil-motion-state-modes 'dired-mode)

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


(use-package evil-commentary
  :straight t
  :diminish
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


(use-package avy
  :straight t
  :custom (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a)))

(use-package evil-easymotion
  :after avy
  :straight t
  :config (evilem-default-keybindings "SPC"))

(use-package link-hint
  :after avy
  :straight t
  :bind (:map evil-motion-state-map ("SPC o" . link-hint-open-link)))


(provide 'init-evil)

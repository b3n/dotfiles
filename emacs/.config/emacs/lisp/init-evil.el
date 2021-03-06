(use-package evil
  :demand
  :straight t

  :init
  (setq evil-want-keybinding nil)

  :bind (:map evil-insert-state-map
         ("C-w" . evil-window-map)

         :map evil-motion-state-map
         ("RET")
         ("SPC" . evil-execute-in-emacs-state)
         ("i"   . evil-insert)

         :map evil-normal-state-map
         ("U"   . undo)
         ("g q" . evil-record-macro)
         ("q"   . bury-buffer)

         :map evil-visual-state-map
         ("U" . undo)
         ("v" . evil-visual-line)

         :map evil-window-map
         ("C-f" . other-frame)
         ("f"   . other-frame))

  :custom
  (evil-disable-insert-state-bindings t)
  (evil-overriding-maps nil)
  (evil-mode-line-format 'after)
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-undo-system 'undo-redo)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  :config
  (setq evil-insert-state-modes (append evil-insert-state-modes evil-emacs-state-modes '(exwm-mode)))
  (setq evil-emacs-state-modes nil)

  (evil-mode 1))


(use-package evil-surround
  :after evil
  :straight t

  :bind (:map evil-normal-state-map
         ("s" . evil-surround-edit)
         ("S" . evil-Surround-edit)
         :map evil-operator-state-map
         ("s" . evil-surround-edit)
         ("S" . evil-Surround-edit)
         :map evil-visual-state-map
         ("s" . evil-surround-region)
         ("S" . evil-Surround-region))

  :config
  ;; Hotfix for repeating surrounds (upstream assumes "ys" binding).
  (defun evil-surround-call-with-repeat (callback)
    (let ((evil-surround-record-repeat t))
      (call-interactively callback))))


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

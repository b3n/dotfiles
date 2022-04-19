(use-package evil
  :demand
  :straight t

  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration nil)

  :bind (:map evil-insert-state-map
         ("C-w" . evil-window-map)

         :map evil-motion-state-map
         ("RET")
         ("<down-mouse-1>")
         ("SPC" . evil-execute-in-emacs-state)
         ("i"   . evil-insert)

         :map evil-normal-state-map
         ("q"   . previous-buffer) ;; Closer to what Emacs does in many modes
         ("Q"   . next-buffer)
         ("g q" . evil-record-macro)

         :map evil-visual-state-map
         ("v" . evil-visual-line) 

         :map evil-window-map
         ("C-f" . other-frame)
         ("f"   . other-frame))

  :custom
  (evil-disable-insert-state-bindings t) ;; Make insert mode like "Emacs mode"
  (evil-echo-state nil) ;; I have more useful things to put here
  (evil-kill-on-visual-paste nil)
  (evil-mode-line-format 'after) ;; It's not important so stick it at the end
  (evil-symbol-word-search t)
  (evil-undo-system 'undo-redo)
  (evil-visual-region-expanded t)
  (evil-want-C-w-in-emacs-state t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  :config
  (setq evil-motion-state-modes (append evil-insert-state-modes evil-emacs-state-modes evil-motion-state-modes))
  (setq evil-insert-state-modes nil)
  (setq evil-emacs-state-modes nil)

  (evil-mode 1))


(use-package evil-surround
  :after evil
  :straight t

  :(config)
  (global-evil-surround-mode 1))


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

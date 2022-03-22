(use-package evil
  :demand
  :straight t

  :init
  (setq evil-want-keybinding nil)

  ;; TODO: Remove this after upgrading emacs to a version which includes undo-redo.
  (defun undo--last-change-was-undo-p (undo-list)
    (while (and (consp undo-list) (eq (car undo-list) nil))
      (setq undo-list (cdr undo-list)))
    (gethash undo-list undo-equiv-table))
  (defun undo-redo (&optional arg)
    "Undo the last ARG undos."
    (interactive "*p")
    (cond
     ((not (undo--last-change-was-undo-p buffer-undo-list))
      (user-error "No undo to undo"))
     (t
      (let* ((ul buffer-undo-list)
             (new-ul
              (let ((undo-in-progress t))
                (while (and (consp ul) (eq (car ul) nil))
                  (setq ul (cdr ul)))
                (primitive-undo arg ul)))
             (new-pul (undo--last-change-was-undo-p new-ul)))
        (message "Redo%s" (if undo-in-region " in region" ""))
        (setq this-command 'undo)
        (setq pending-undo-list new-pul)
        (setq buffer-undo-list new-ul)))))

  :bind (:map evil-insert-state-map
         ("C-w" . evil-window-map)

         :map evil-motion-state-map
         ("RET")
         ("SPC" . evil-execute-in-emacs-state)
         ("i"   . evil-insert)
         ("q"   . previous-buffer)
         ("Q"   . next-buffer)

         :map evil-normal-state-map
         ("U"   . undo)
         ("g q" . evil-record-macro)

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


(use-package evil-exchange
  :after evil
  :straight t
  :config
  (evil-exchange-install))


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

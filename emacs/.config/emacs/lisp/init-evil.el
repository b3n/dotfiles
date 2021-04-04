(use-package evil
  :demand
  :straight t

  :init
  (setq evil-want-keybinding nil)
  (setq evil-disable-insert-state-bindings t)

  :bind (:map evil-insert-state-map
         ("C-w" . evil-window-map)
         :map evil-motion-state-map
         ("<down>"  . my-evil-next-line-skip-blank)
         ("<left>"  . my-evil-previous-indentation)
         ("<right>" . my-evil-next-indentation) 
         ("<up>"    . my-evil-previous-line-skip-blank)
         ("RET"     . push-button)
         ("SPC"     . evil-execute-in-emacs-state)
         ("g q"     . evil-record-macro)
         ("q"       . burry-buffer)
         ("U"       . undo)
         :map evil-normal-state-map
         :map evil-visual-state-map
         ("v" . evil-visual-line)
         :map evil-window-map
         ("C-f" . other-frame))

  :custom
  (evil-insert-state-modes (append evil-insert-state-modes evil-emacs-state-modes))
  (evil-emacs-state-modes nil)
  ;(evil-intercept-maps nil)
  (evil-overriding-maps nil)

  (evil-mode-line-format 'after)
  (evil-search-module 'evil-search)
  (evil-symbol-word-search t)
  (evil-undo-system 'undo-redo)
  (evil-want-Y-yank-to-eol t)
  (evil-want-minibuffer t)

  :config
  (evil-define-motion my-evil-next-line-skip-blank (&optional count)
    "Go down to the first next line in this column that isn't blank."
    :jump t
    :type line
    (let ((col (current-column)))
      (evil-next-line-first-non-blank count)
      (while (or (> (current-column) (move-to-column col))
                 (eq (char-after) ?\C-j))
        (evil-next-line-first-non-blank count))))
 
  (evil-define-motion my-evil-previous-line-skip-blank (&optional count)
    "Go up to the first previous line in this column that isn't blank."
    :jump t
    :type line
    (my-evil-next-line-skip-blank (- (or count 1))))

  (evil-define-motion my-evil-next-indentation (&optional count)
    "Go to the next indentation level, or end of line. It's like move-to-tab-stop, but more fun."
    (let ((point (point))
          (indents nil))
      (goto-char (point-min))
      (ignore-errors
        (while t
          (evil-next-line-first-non-blank)
          (add-to-list 'indents (current-column))))
      (goto-char point)
      (move-to-column
       (catch 'move-to
         (dolist (indent (sort indents #'<))
           (when (> indent (current-column))
             (throw 'move-to indent)))  
           999))))

  (evil-define-motion my-evil-previous-indentation (&optional count)
    "Go to the previous indentation level, or beginning of line."
    (let ((point (point))
          (indents nil))
      (goto-char (point-min))
      (ignore-errors
        (while t
          (evil-next-line-first-non-blank)
          (add-to-list 'indents (current-column))))
      (goto-char point)
      (move-to-column
       (catch 'move-to
         (dolist (indent (sort indents #'>))
           (when (< indent (current-column))
             (throw 'move-to indent)))  
           0))))

  (evil-mode 1)

  ;; This is needed because we disable evil insert state bindings, but still want C-w.
  (evil-global-set-key 'insert (kbd "C-w") 'evil-window-map))


(use-package evil-surround
  ;; TODO: Setup better bindings (e.g. use `s` instead of `ys`)
  :after evil
  :straight t

  :config
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

(load "server")
(unless (server-running-p) (server-start))

(setq enable-local-variables nil
      network-security-level 'paranoid)

(setq custom-file (make-temp-file "emacs-custom")
      create-lockfiles nil
      make-backup-files nil)

(setq-default tab-width 4
              indent-tabs-mode nil)

(load "~/.emacs.d/funcs.el")

(my-use-package-initialize)

(setq my-prefix "SPC")

(general-create-definer my-leader-def
  :states '(normal visual insert emacs)
  :keymaps 'override
  :global-prefix (concat "M-" my-prefix)
  :prefix my-prefix)

(defun my-leader-map (key map)
  (define-key key-translation-map (kbd (concat my-prefix " " key)) (kbd map))
  (define-key key-translation-map (kbd (concat "M-" my-prefix " " key)) (kbd map)))

(my-leader-map "c" "C-c")
(my-leader-map "x" "C-x")
(my-leader-map "h" "C-h")

(my-leader-def
  "B" #'ibuffer-list-buffers
  "f" '(:ignore t :which-key "File")
  "f d" #'dired-jump
  "f s" #'save-buffer
  "f y" #'my-show-buffer-file-name
  "!" #'shell-command
  "<tab>" #'mode-line-other-buffer)

(general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil)

(mapc 'load (file-expand-wildcards "~/.emacs.d/packages/*.el"))

(let ((ws-config (concat
                  "~/.emacs.d/window-system/"
                  (symbol-name window-system)
                  ".el")))
  (when (file-readable-p ws-config)
    (load ws-config)))


(tool-bar-mode -1)

(show-paren-mode 1)

(add-hook 'text-mode-hook 'flyspell-mode)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(savehist-mode)

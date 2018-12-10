(load "server")
(unless (server-running-p) (server-start))

(setq custom-file (make-temp-file "emacs-custom")
      create-lockfiles nil
      make-backup-files nil)
(setq-default tab-width 4
              indent-tabs-mode nil)

(load "~/.emacs.d/funcs.el")

(my-use-package-initialize)

(general-create-definer my-leader-def
  :states '(normal visual insert emacs)
  :keymaps 'override
  :prefix "SPC"
  :non-normal-prefix "M-SPC")

(define-key key-translation-map (kbd "SPC c") (kbd "C-c"))
(define-key key-translation-map (kbd "SPC x") (kbd "C-x"))

(my-leader-def "h" '(:ignore t :which-key "Help"))
(define-key key-translation-map (kbd "SPC h") (kbd "C-h"))

(my-leader-def
  "f" '(:ignore t :which-key "File")
  "f d" #'dired-jump
  "f s" #'save-buffer
  "f y" #'my-show-buffer-file-name

  "<tab>" #'my-alternate-buffer
  "<return>" #'eshell
  "!" #'shell-command)

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
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(customize-set-variable 'gc-cons-threshold 100000000)
(customize-set-variable 'network-security-level 'paranoid)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(customize-set-variable 'straight-use-package-by-default t)
;;(use-package-ensure-system-package)


(use-package emacs
  :straight nil
  :custom
  (create-lockfiles nil)
  :config
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4))


(use-package server
  :disabled
  :straight nil
  :config
  (unless (server-running-p) (server-start)))


(use-package general
  :init
  (setq my-prefix "<f5>")

  :config
  (general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil)
  (general-create-definer my-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'override
    :global-prefix (concat "M-" my-prefix)
    :prefix my-prefix))


(use-package files
  :straight nil
  :custom
  (enable-local-variables nil)
  (backup-by-copying t)
  (backup-directory-alist '((".*" . "~/.emacs.d/saves/")))
  (version-control t)
  (delete-old-versions t)

  :config
  (auto-save-visited-mode)
  (my-leader-def
    "f" '(:ignore t :which-key "File")
    "f y" #'my-show-buffer-file-name
    "!" #'shell-command))


(use-package cus-edit
  :straight nil
  :custom
  (custom-file (make-temp-file "emacs-custom")))


(use-package emacs ;startup
  :straight nil
  :custom
  (inhibit-startup-screen t)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))


(use-package tool-bar
  :straight nil
  :config
  (tool-bar-mode -1))


(use-package paren
  :straight nil
  :config
  (show-paren-mode 1))


(use-package simple
  :straight nil
  :hook (text-mode . turn-on-visual-line-mode)
  :custom
  (visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)))


(use-package flyspell
  :straight nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


(use-package savehist
  :straight nil
  :config
  (savehist-mode))


(use-package emacs ;window
  :straight nil
  :custom
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window)))))


(let ((ws-config (concat
                  "~/.emacs.d/window-system/"
                  (symbol-name window-system)
                  ".el")))
  (when (file-readable-p ws-config)
    (load ws-config)))


(mapc 'load (file-expand-wildcards "~/.emacs.d/lisp/*.el"))


(customize-set-variable 'gc-cons-threshold 1000000)

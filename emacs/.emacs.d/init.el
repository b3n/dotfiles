;; -*- lexical-binding: t; -*-

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

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer my-leader
    :states '(normal visual insert emacs)
    :keymaps 'override
    :global-prefix "M-SPC"
    :prefix "SPC"))


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-core)
(require 'init-theme)
(require 'init-tab-bar)
(require 'init-org)
(require 'init-icomplete)
(require 'init-undo-tree)
(require 'init-evil)
(require 'init-dired)
(require 'init-default-text-scale)
(require 'init-flycheck)
(require 'init-which-key)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-avy)
(require 'init-grep)
(require 'init-lsp)
(require 'init-auctex)
(require 'init-csv)
(require 'init-json)
(require 'init-markdown)
(require 'init-rust)
(require 'init-yaml)
(require 'init-git)
(require 'init-irc)
(require 'init-password-gen)
(require 'init-restclient)
(require 'init-shell)
(require 'init-email)
(require 'init-openwith)
(require 'init-window-manager)

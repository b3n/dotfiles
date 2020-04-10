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

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-core)
(require 'init-dired)
(require 'init-theme)
(require 'init-evil)
(require 'init-ivy)
(require 'init-undo-tree)
(require 'init-which-key)
(require 'init-openwith)
(require 'init-default-text-scale)
(require 'init-flycheck)
(require 'init-company)
(require 'init-yasnippet)

(require 'init-lsp)
(require 'init-org)
(require 'init-emacs-lisp)
(require 'init-auctex)
(require 'init-csv)
(require 'init-json)
(require 'init-markdown)
(require 'init-rust)
(require 'init-yaml)

(require 'init-vlf)
(require 'init-git)
(require 'init-irc)
(require 'init-password-gen)
(require 'init-restclient)
(require 'init-shell)
(require 'init-email)
(require 'init-exwm)

;; TODO (in order of priority):
;; - Deprecate general.el (again)
;; - Consolidate init files under better groupings

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

(use-package general
  :straight t

  :config
  (general-create-definer my-leader :prefix "C-c")
  (general-define-key :states 'normal :keymaps 'override "DEL" (general-simulate-key "C-w"))
  (general-define-key :states 'normal :keymaps 'override "SPC" (general-simulate-key "C-x"))
  (general-define-key :states 'normal :keymaps 'override "," (general-simulate-key "C-c")))


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-core)
(require 'init-theme)
(require 'init-tab-bar)
(require 'init-org)
(require 'init-minibuffer)
(require 'init-undo-tree)
(require 'init-evil)
(require 'init-dired)
(require 'init-flycheck)
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
(require 'init-vc)
(require 'init-irc)
(require 'init-password-gen)
(require 'init-restclient)
(require 'init-shell)
(require 'init-email)
(require 'init-openwith)
(require 'init-window-manager)
(require 'init-vlf)

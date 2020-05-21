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


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-core)
(require 'init-theme)
(require 'init-minibuffer)

;; Minor modes
(require 'init-evil)
(require 'init-flycheck)
(require 'init-yasnippet)
(require 'init-avy)
(require 'init-grep)
(require 'init-password-gen)
(require 'init-openwith)
(require 'init-lsp)

;; Major modes
(require 'init-shell)
(require 'init-calc)
(require 'init-email) ;; TODO: Email setup
(require 'init-irc)
(require 'init-vc)
(require 'init-dired)
(require 'init-window-manager)
(require 'init-restclient)
(require 'init-vlf)
(require 'init-prog-modes)
(require 'init-text-modes)

(require 'server)
(unless (server-running-p)
  (server-start))

(setq custom-file (make-temp-file "emacs-custom")
      create-lockfiles nil
      make-backup-files nil)

(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(use-package use-package-ensure-system-package :config (exec-path-from-shell-initialize))
(use-package diminish)
(use-package general)

(setq my-prefix "<f5>")

(general-define-key :prefix my-prefix
		    "f s" #'save-buffer
		    "<return>" #'ansi-term)

(general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil) 

(setq browse-url-generic-program "firefox")
(setq-default tab-width 4
	      indent-tabs-mode nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(show-paren-mode 1)
(winner-mode 1)
(recentf-mode 1)
(flyspell-mode)

(mapc 'load (file-expand-wildcards "~/.emacs.d/packages/*.el"))

(cond ((eq window-system 'ns) (load "~/.emacs.d/platform/osx.el"))
      ((eq window-system 'x) (load "~/.emacs.d/platform/nix.el")))

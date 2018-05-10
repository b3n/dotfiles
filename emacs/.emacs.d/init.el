(require 'server)
(unless (server-running-p)
  (server-start))


(setq custom-file (make-temp-file "emacs-custom")
      create-lockfiles nil
      make-backup-files nil)
(setq browse-url-generic-program "firefox")
(setq-default tab-width 4
              indent-tabs-mode nil)

(load "~/.emacs.d/funcs.el")

(package-initialize)
(my-use-package-initialize)

(setq my-prefix "<f5>")

(general-define-key :prefix my-prefix
                    "f s" #'save-buffer
                    "f y" #'my-show-buffer-file-name
                    "<return>" #'eshell
                    "!" #'shell-command)

(general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil) 

(mapc 'load (file-expand-wildcards "~/.emacs.d/packages/*.el"))

(cond ((eq window-system 'ns) (load "~/.emacs.d/platform/osx.el"))
      ((eq window-system 'x) (load "~/.emacs.d/platform/nix.el")))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(show-paren-mode 1)
(winner-mode 1)
(recentf-mode 1)
(flyspell-mode)

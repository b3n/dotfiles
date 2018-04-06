(require 'server)
(unless (server-running-p)
  (server-start))

(package-initialize)
(setq custom-file (make-temp-file "emacs-custom"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(setq use-package-always-ensure t)
(use-package use-package-ensure-system-package)
(use-package diminish)
(use-package general)

(setq my-prefix "<f5>")

(general-define-key :prefix my-prefix
		    "f s" #'save-buffer
		    "<return>" #'ansi-term)

(setq create-lockfiles nil)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq browse-url-generic-program "firefox")

(recentf-mode 1)

(setq tab-width 4)
(setq indent-tabs-mode nil)

(flyspell-mode)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(show-paren-mode 1)


(setq erc-lurker-hide-list '("JOIN" "PART" "QUIT")
      erc-lurker-threshold-time 3600)
(setq erc-join-buffer 'bury)
(setq erc-nick "Ben`")
(setq erc-format-query-as-channel-p t
      erc-track-priority-faces-only 'all
      erc-track-faces-priority-list '(erc-error-face
				      erc-current-nick-face
				      erc-keyword-face
				      erc-nick-msg-face
				      erc-direct-msg-face
				      erc-dangerous-host-face
				      erc-notice-face
				      erc-prompt-face))


;;; Some ansi-term advice, stolen from http://echosa.github.io/blog/2012/06/06/improving-ansi-term/.
;; Kill the buffer on exit
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

;; Always use Bash, instead of asking me every time
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


(winner-mode 1)



(mapc 'load (file-expand-wildcards "~/.emacs.d/packages/*.el"))


(when (eq window-system 'ns)
  (load "~/.emacs.d/platform/osx.el"))

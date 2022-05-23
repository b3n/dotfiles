;;; early-init.el --- Ben's configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; The initiation of the initiation.  This file is loaded before the package
;; system and GUI are initialised.  See also: `init.el'.

;;; Code:

(setq create-lockfiles nil)
(setq frame-inhibit-implied-resize t)
(setq frame-title-format '("%b — %F"))
(setq indicate-buffer-boundaries 'right)
(setq mouse-autoselect-window t)
(setq visible-bell t)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(tool-bar-mode 0)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; early-init.el ends here

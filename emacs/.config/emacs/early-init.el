;;; init.el -- Ben's configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; The initiation of the initiation.  This file is loaded before the package
;; system and GUI are initialised.

;;; Code:

(setq completion-ignore-case t)
(setq create-lockfiles nil)
(setq frame-inhibit-implied-resize t)
(setq indicate-buffer-boundaries 'right)
(setq mouse-autoselect-window t)
(setq visible-bell t)

(setq-default fill-column 88)
(setq-default frame-title-format '("%n %b - %F"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(put 'narrow-to-region 'disabled nil)

(menu-bar-mode 0)
(tool-bar-mode 0)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)
(unless (package-installed-p 'setup) (package-install 'setup))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

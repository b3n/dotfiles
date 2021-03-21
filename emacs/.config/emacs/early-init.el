;; https://github.com/emacs-lsp/lsp-mode#performance
(setq gc-cons-threshold 99999999)
(setq read-process-output-max 9999999)
(setq bidi-inhibit-bpa t)

(setq completion-ignore-case t)
(setq create-lockfiles nil)
(setq frame-inhibit-implied-resize t)
(setq package-enable-at-startup nil)
(setq visible-bell t)

(setq-default fill-column 100)
(setq-default frame-title-format '("%n %b - %F"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(put 'narrow-to-region 'disabled nil)

(menu-bar-mode 0)
(tool-bar-mode 0)

(fset 'yes-or-no-p 'y-or-n-p)

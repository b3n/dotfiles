(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(horizontal-scroll-bar-mode 0)

(fset 'yes-or-no-p 'y-or-n-p)

;; https://github.com/emacs-lsp/lsp-mode#performance
(setq gc-cons-threshold 99999999)
(setq read-process-output-max 9999999)

(setq completion-ignore-case t)
(setq create-lockfiles nil)
(setq frame-inhibit-implied-resize t)
(setq package-enable-at-startup nil)
(setq x-selection-timeout 10) ;; https://omecha.info/blog/org-capture-freezes-emacs.html

(setq-default frame-title-format '("%b - Emacs"))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default show-trailing-whitespace t)


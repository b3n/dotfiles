(use-package server
  :config
  (server-start))


(use-package emacs
  :after evil
  :bind (:map evil-window-map
         ("d" . toggle-window-dedicated))

  :init
  (defun toggle-window-dedicated ()
    "Toggle whether the current active window is dedicated or not"
    (interactive)
    (message
     (if (let (window (get-buffer-window (current-buffer)))
           (set-window-dedicated-p window (not (window-dedicated-p window))))
         "`%s' is dedicated!"
       "`%s' is undedicated")
     (current-buffer)))

  (setq-default mode-line-format (cons '(:eval (when (window-dedicated-p) "🔒")) mode-line-format)))


(use-package files
  :custom
  (auto-save-default t)
  (backup-by-copying t)
  (backup-directory-alist `((".*" . ,(expand-file-name "backups" user-emacs-directory))))
  (confirm-kill-emacs 'yes-or-no-p)
  (delete-old-versions t)
  (enable-dir-local-variables nil)
  (enable-local-variables nil)
  (kept-new-versions 99)
  (vc-make-backup-files t)
  (version-control t)

  :config
  (auto-save-visited-mode))

(use-package auth-source
  :custom
  (auth-sources '("/tmp/.authinfo" "~/.authinfo.gpg"))) ; Don't write passwords unencrypted on disk...


(use-package cus-edit
  :custom
  (custom-file (make-temp-file "emacs-custom")))


(use-package emacs ;startup
  :custom
  (inhibit-startup-screen t)
  (initial-scratch-message ""))


(use-package paren
  :config
  (show-paren-mode 1))


(use-package simple
  :hook (text-mode . turn-on-visual-line-mode)

  :custom
  (completion-show-help nil)
  (async-shell-command-buffer 'rename-buffer)

  :config
  (column-number-mode))


(use-package flyspell
  :disabled
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


(use-package saveplace
  :config
  (save-place-mode 1))


(use-package emacs ;window
  :custom
  (mouse-autoselect-window t)
  (display-buffer-alist
   '((".*" (display-buffer-reuse-window display-buffer-same-window)))))


(use-package uniquify
  :custom (uniquify-buffer-name-style 'forward))


(use-package find-file-in-project
  :straight t
  :bind (("C-x F" . find-file-in-project)
         ("C-x f" . find-file-in-project-by-selected))
  :config
  (setq ffip-use-rust-fd t))


(use-package emacs ; indent
  :custom
  (tab-always-indent 'complete))


(use-package tab-bar
  :bind-keymap ("C-x C-t" . tab-prefix-map)
  :bind (:map tab-prefix-map
         ("q" . tab-close)
         ("u" . tab-undo)
         ("t" . tab-bar-switch-to-recent-tab))

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-close-button nil)
  (tab-bar-show 1))


(use-package isearch
  :custom (isearch-lazy-count t))


(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)

  :hook (ibuffer-mode . (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

  :custom
  (ibuffer-saved-filter-groups '(("default"
                                  ("web" (and (mode . exwm-mode)
                                              (or (name . "^Firefox")
                                                  (name . "^Chrom")
                                                  (name . "^qute"))))))))


(use-package flymake
  :hook (prog-mode . flymake-mode)

  :custom
  (flymake-no-changes-timeout nil)
  (flymake-wrap-around nil))


(use-package hippie-exp
  :custom
  (hippie-expand-try-functions-list '(try-expand-dabbrev-visible
                                      try-complete-file-name-partially
                                      try-complete-file-name
                                      try-expand-dabbrev
                                      try-expand-all-abbrevs
                                      try-expand-line
                                      try-expand-list
                                      try-expand-dabbrev-all-buffers
                                      try-expand-dabbrev-from-kill
                                      try-complete-lisp-symbol-partially
                                      try-complete-lisp-symbol))

  :config
  (global-set-key [remap dabbrev-expand] #'hippie-expand))


(provide 'init-core)

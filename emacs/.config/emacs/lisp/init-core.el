(use-package server
  :config
  (server-start))


(use-package files
  :custom
  (auto-save-default t)
  (auto-save-visited-interval 60)
  (backup-by-copying t)
  (backup-directory-alist `((,tramp-file-name-regexp . nil)
                            (".*" . ,(expand-file-name "backups" user-emacs-directory))))
  (confirm-kill-emacs 'yes-or-no-p)
  (delete-old-versions t)
  (enable-dir-local-variables nil)
  (enable-local-eval nil)
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


(use-package uniquify
  :custom (uniquify-buffer-name-style 'forward))


(use-package find-file-in-project
  :straight t
  :bind (("C-x F" . find-file-in-project)
         ("C-x f" . find-file-in-project-by-selected))
  :config
  (setq ffip-use-rust-fd t))


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
  :custom
  (isearch-lazy-count t))


(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))


(use-package flymake
  :hook (prog-mode . flymake-mode)

  :custom
  (flymake-no-changes-timeout nil)
  (flymake-wrap-around nil))


(use-package man
  :custom
  (Man-notify-method 'pushy))


(use-package hippie-exp
  :config
  (global-set-key [remap dabbrev-expand] #'hippie-expand))


(use-package bookmark
  :custom
  (bookmark-save-flag 1))


(provide 'init-core)

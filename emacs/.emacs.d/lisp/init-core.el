(use-package emacs
  :straight nil
  :config
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4))


(use-package server
  :disabled
  :straight nil
  :config
  (unless (server-running-p) (server-start)))


(use-package general ; TODO: Deprecate
  :init
  (setq my-prefix "<f5>")

  :config
  (general-define-key :keymaps 'minibuffer-inactive-mode-map [mouse-1] nil)
  (general-create-definer my-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'override
    :global-prefix (concat "M-" my-prefix)
    :prefix my-prefix))


(use-package files
  :straight nil
  :custom
  (enable-local-variables nil)
  (backup-by-copying t)
  (backup-directory-alist '((".*" . "~/.emacs.d/saves/")))
  (version-control t)
  (delete-old-versions t)

  :config
  (auto-save-visited-mode)
  (my-leader-def
    "f" '(:ignore t :which-key "File")
    "f y" #'my-show-buffer-file-name
    "!" #'shell-command))


(use-package cus-edit
  :straight nil
  :custom
  (custom-file (make-temp-file "emacs-custom")))


(use-package emacs ;startup
  :straight nil
  :custom
  (inhibit-startup-screen t)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))


(use-package paren
  :straight nil
  :config
  (show-paren-mode 1))


(use-package simple
  :straight nil
  :hook (text-mode . turn-on-visual-line-mode)
  :custom
  (visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)))


(use-package flyspell
  :straight nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


(use-package savehist
  :straight nil
  :config
  (savehist-mode))


(use-package emacs ;window
  :straight nil
  :custom
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window)))))


(provide 'init-core)

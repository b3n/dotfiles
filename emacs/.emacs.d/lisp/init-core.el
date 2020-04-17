(use-package files
  :straight nil

  :custom
  (enable-local-variables nil)
  (backup-by-copying t)
  (backup-directory-alist '((".*" . "~/.emacs.d/saves/")))
  (version-control t)
  (delete-old-versions t)

  :config
  (auto-save-visited-mode))


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
  :bind ("s-p" . async-shell-command)
  :hook (text-mode . turn-on-visual-line-mode)

  :custom
  (async-shell-command-buffer 'new-buffer)

  :config
  (size-indication-mode)
  (column-number-mode))


(use-package flyspell
  :straight nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


(use-package saveplace
  :straight nil

  :config
  (save-place-mode 1))


(use-package emacs ;window
  :straight nil
  :demand
  :bind ("s-b" . switch-to-buffer)

  :custom
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window))
     ("\\*Async Shell Command" (display-buffer-no-window)))))


(use-package recentf
  :straight nil
  
  :custom
  (recentf-max-menu-items 99)
  (recentf-max-saved-items 999)

  :config
  (recentf-mode))


(provide 'init-core)

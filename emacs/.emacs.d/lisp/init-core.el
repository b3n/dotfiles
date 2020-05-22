(use-package files
  :custom
  (backup-by-copying t)
  (backup-directory-alist '((".*" . "~/.emacs.d/saves/")))
  (confirm-kill-emacs 'yes-or-no-p)
  (delete-old-versions t)
  (enable-local-variables nil)
  (version-control t)

  :config
  (auto-save-visited-mode))


(use-package cus-edit
  :custom
  (custom-file (make-temp-file "emacs-custom")))


(use-package emacs ;startup
  :custom
  (inhibit-startup-screen t)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))


(use-package paren
  :config
  (show-paren-mode 1))


(use-package simple
  :hook (text-mode . turn-on-visual-line-mode)

  :custom
  (completion-show-help nil)

  :config
  (size-indication-mode)
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
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window)))))


(use-package recentf
  :bind ("C-c r" . recentf-open-files)

  :custom
  (recentf-max-saved-items 999)

  :config
  (recentf-mode))


(use-package uniquify
  :custom (uniquify-buffer-name-style 'forward))


(use-package project
  :init
  (defun my-find-all-files ()
    "Find all files within a particular directory."
    (interactive)
    (project-find-file-in
     nil
     nil
     (cons 'transient (read-directory-name "Choose the directory: " "~/" nil t))))

  :bind (("C-x f" . project-find-file)
         ("C-x F" . my-find-all-files)))


(use-package emacs ; indent
  :custom
  (tab-always-indent 'complete))


(use-package tab-bar
  :bind-keymap ("C-x C-t" . tab-prefix-map)
  :bind (:map tab-prefix-map
         ("q" . tab-close)
         ("u" . tab-undo)
         ("t" . tab-new))

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-close-button nil)
  (tab-bar-show 1))



(use-package isearch
  :disabled
  :custom
  (isearch-lazy-count t)
  (lazy-count-prefix-format nil)
  (lazy-count-suffix-format "  (%s/%s)"))


(use-package desktop
  :custom
  (desktop-restore-eager 9)

  :config
  (desktop-save-mode 1))


(use-package midnight)


(use-package browse-url
  :custom
  (browse-url-handlers '(("\\`file:" . browse-url-default-browser))))


(provide 'init-core)

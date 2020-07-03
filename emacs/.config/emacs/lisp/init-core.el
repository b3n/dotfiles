(use-package files
  :custom
  (backup-by-copying t)
  (backup-directory-alist `((".*" . ,(expand-file-name "backups" user-emacs-directory))))
  (delete-old-versions t)
  (kept-new-versions 99)
  (vc-make-backup-files t)
  (version-control t)

  (enable-local-variables nil)
  (confirm-kill-emacs 'yes-or-no-p)

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
  (column-number-mode))


(use-package flyspell
  :disabled
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


(use-package saveplace
  :config
  (save-place-mode 1))


(use-package emacs ;window
  :init
  (defun my-switch-to-mode-buffer ()
    (interactive)
    (switch-to-buffer
     (let ((current-major-mode major-mode))
       (read-buffer (format "Switch to %s buffer: " current-major-mode)
                    nil
                    t
                    (lambda (buffer)
                      (when (consp buffer) (setq buffer (cdr buffer)))
                      (string= current-major-mode (buffer-local-value 'major-mode buffer)))))))

  :bind ("C-x C-b" . my-switch-to-mode-buffer)
  
  :custom
  (mouse-autoselect-window t)
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window)))))


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
     (cons 'transient (read-directory-name "Choose the directory: " nil nil t))))

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
         ("t" . tab-bar-switch-to-recent-tab))

  :custom
  (tab-bar-new-tab-choice "*scratch*")
  (tab-bar-close-button nil)
  (tab-bar-show 1))


(use-package isearch
  :custom (isearch-lazy-count t))


(use-package flymake
  :hook (prog-mode . flymake-mode)

  :custom
  (flymake-no-changes-timeout nil)
  (flymake-wrap-around nil))


(use-package hippie-exp
  :config
  (global-set-key [remap dabbrev-expand] #'hippie-expand))


(provide 'init-core)

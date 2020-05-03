(use-package files
  :straight nil
  :general (my-leader
             "f" '(:ignore t :wk "File")
             "f f" #'find-file
             "f s" #'save-buffer)

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
  :general (my-leader
             "SPC" #'execute-extended-command
             "u" #'universal-argument
             "p" #'async-shell-command)
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
  :general (my-leader "b" #'switch-to-buffer)

  :custom
  (display-buffer-alist
   '(("\\*shell" (display-buffer-reuse-window display-buffer-same-window))
     ("\\*Async Shell Command" (display-buffer-no-window)))))


(use-package recentf
  :straight nil
  :after dired
  :general (my-leader "f r" '((lambda () (interactive) (dired (cons "*Recentf Dired*" recentf-list)))
                              :wk "Recent files"))

  :custom
  (recentf-max-saved-items 999)

  :config
  (recentf-mode))


(use-package help
  :straight nil
  :general (my-leader "h" '(:keymap help-map :wk "Help"))
  :custom (help-window-select t))


(use-package calc
  :straight nil
  :general (my-leader "a c" #'calc-dispatch))


(use-package uniquify
  :straight nil
  :custom (uniquify-buffer-name-style 'forward))


(provide 'init-core)

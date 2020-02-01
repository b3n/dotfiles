(use-package ivy
  :general (my-leader-def
             "DEL" #'ivy-resume
             "b" #'ivy-switch-buffer
             "v v" #'ivy-switch-view
             "v p" #'ivy-push-view
             "v k" #'ivy-pop-view)

  :diminish ivy-mode

  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-selectable-prompt t)
  (ivy-use-virtual-buffers t)

  :init
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq ivy-initial-inputs-alist nil)

  :config
  (ivy-mode 1)

  (defun setup-eshell-ivy-completion ()
    (define-key eshell-mode-map [remap eshell-pcomplete] 'completion-at-point)
    ;; only if you want to use the minibuffer for completions instead of the
    ;; in-buffer interface
    (setq-local ivy-display-functions-alist
                (remq (assoc 'ivy-completion-in-region ivy-display-functions-alist)
                      ivy-display-functions-alist)))

  (add-hook 'eshell-mode-hook #'setup-eshell-ivy-completion))

(use-package amx
  :config
  (amx-mode))

(use-package counsel
  :init
  (setq recentf-max-saved-items 999)
  (recentf-mode 1)
  
  :general (my-leader-def
             "g f" #'counsel-git
             "g /" #'counsel-git-grep
             "f f" #'counsel-find-file
             "f r" #'counsel-recentf
             "p" #'counsel-linux-app
             "u" #'counsel-unicode-char
             my-prefix #'counsel-M-x
             (concat "M-" my-prefix) #'counsel-M-x)
  :diminish counsel-mode
  :config
  (counsel-mode))

(use-package all-the-icons-ivy
  :after (all-the-icons ivy)
  :config
  (all-the-icons-ivy-setup))

(use-package ivy-prescient
  :config
  (ivy-prescient-mode))

(use-package avy
  :general (my-leader-def
             "a" #'avy-goto-char))

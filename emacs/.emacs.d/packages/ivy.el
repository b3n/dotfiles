(use-package ivy
  :general (my-leader-def
             "i" #'ivy-resume
             "b" #'ivy-switch-buffer
             "v v" #'ivy-switch-view
             "v p" #'ivy-push-view
             "v k" #'ivy-pop-view)

  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-selectable-prompt t)
  (ivy-use-virtual-buffers t)

  :config
  (ivy-mode 1)

  (general-define-key :map ivy-minibuffer-map "s-<return>" #'ivy-done)

  (defun setup-eshell-ivy-completion ()
    (define-key eshell-mode-map [remap eshell-pcomplete] 'completion-at-point)
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

  :custom
  (counsel-root-command "doas")  ;; OpenBSD
  
  :general (my-leader-def
             "g f" #'counsel-git
             "g /" #'counsel-git-grep
             "f f" #'counsel-find-file
             "f r" #'counsel-recentf
             "p" #'counsel-linux-app
             "u" #'counsel-unicode-char
             my-prefix #'counsel-M-x
             (concat "M-" my-prefix) #'counsel-M-x)
  :config
  (counsel-mode))

(use-package all-the-icons-ivy
  :after (all-the-icons ivy)
  :custom (all-the-icons-ivy-buffer-commands '(ivy-switch-buffer counsel-find-file))
  :config (all-the-icons-ivy-setup))

(use-package ivy-prescient
  :custom
  (prescient-persist-mode t)
  :config
  (ivy-prescient-mode))

(use-package avy
  :custom
  (avy-keys '(?n ?t ?e ?s ?i ?r ?o ?a))

  :config
  (general-define-key :states 'normal "s" #'avy-goto-char)
  (general-define-key :states 'normal "S" #'avy-pop-mark))


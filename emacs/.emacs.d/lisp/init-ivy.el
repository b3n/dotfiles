(use-package ivy
  :bind (("C-c C-r" . ivy-resume)
         ("C-c b" . ivy-switch-buffer)
         ("C-c v" . ivy-push-view)
         ("C-c V" . ivy-pop-view))

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
  ;;(setq recentf-max-saved-items 999)
  ;;(recentf-mode 1)

  :bind (
         ("C-c k" . counsel-rg)
         ("C-c p" . counsel-linux-app)
         ("C-x f" . counsel-find-file))

  :custom
  (counsel-root-command "doas")  ;; OpenBSD
  
  :general (my-leader-def
             "g f" #'counsel-git
             "g /" #'counsel-git-grep
             "u" #'counsel-unicode-char
             )
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
  (general-define-key :states 'motion
                      "s" #'avy-goto-char
                      "S" #'avy-pop-mark))

(use-package ivy-hydra)


(provide 'init-ivy)

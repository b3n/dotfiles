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

  (define-key ivy-minibuffer-map (kbd "s-<return>") #'ivy-done)

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
  :bind (("C-c k" . counsel-rg)
         ("C-c p" . counsel-linux-app)
         ("C-c u" . counsel-unicode-char)
         ("C-c g f" . counsel-git)
         ("C-c g /" . counsel-git-grep)
         ("C-x f" . counsel-find-file))

  :custom
  (counsel-root-command "doas")
  
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
  (evil-define-key '(normal visual) 'global
    "s" #'avy-goto-char
    "S" #'avy-pop-mark))

(use-package ivy-hydra)


(provide 'init-ivy)

(use-package ivy
  :general (my-leader-def
             "v a" #'ivy-push-view
             "v d" #'ivy-pop-view
             "v v" #'ivy-switch-view
             "B" #'ivy-switch-buffer)
  :diminish ivy-mode
  :custom
  (ivy-use-virtual-buffers t)
  :init
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1))


(use-package counsel
  :general (my-leader-def
             "i" #'ivy-resume
             "g f" #'counsel-git
             "g /" #'counsel-git-grep
             "/" #'counsel-ag
             "f f" #'counsel-find-file
             "f r" #'counsel-recentf
             "SPC" #'counsel-M-x)
  :diminish counsel-mode
  :config
  (counsel-mode))

(use-package ivy
  :general (my-leader-def
             "DEL" #'ivy-resume
             "b" #'ivy-switch-buffer
             "v" #'ivy-push-view
             "V" #'ivy-pop-view)

  :diminish ivy-mode

  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")

  :init
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq ivy-initial-inputs-alist nil)

  :config
  (ivy-mode 1))

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
             "t p" #'counsel-linux-app
             "u" #'counsel-unicode-char
             "SPC" #'counsel-M-x)
  :diminish counsel-mode
  :config
  (counsel-mode))

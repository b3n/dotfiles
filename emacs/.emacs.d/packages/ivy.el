(use-package ivy
  :general (:prefix my-prefix
		    "v a" #'ivy-push-view
		    "v d" #'ivy-pop-view
		    "v v" #'ivy-switch-view
		    "B" #'ivy-switch-buffer)
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1))


(use-package counsel
  :general (:prefix my-prefix
		    "SPC" #'counsel-linux-app
		    "i" #'ivy-resume
		    "g f" #'counsel-git
		    "g /" #'counsel-git-grep
		    "/" #'counsel-ag
		    "f f" #'counsel-find-file
		    "f r" #'counsel-recentf
		    "<f5>" #'counsel-M-x)
  :diminish counsel-mode
  :config
  (counsel-mode))

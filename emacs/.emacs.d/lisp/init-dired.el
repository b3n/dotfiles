(use-package dired
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches "-hal")
  (dired-dwim-target t))

(use-package image-dired
  :custom
  (image-dired-thumb-size 500))

(use-package dired-x
  :bind ("C-c f d" . dired-jump))

(use-package all-the-icons
  :disabled)

(use-package all-the-icons-dired
  :disabled
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package async
  :straight t)

(use-package dired-async
  :after (dired async)
  :hook (dired-mode . dired-async-mode))


(provide 'init-dired)

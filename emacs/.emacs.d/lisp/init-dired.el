(use-package dired
  :straight nil
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches "-hal")
  (dired-dwim-target t))

(use-package image-dired
  :straight nil
  :custom
  (image-dired-thumb-size 500))

(use-package dired-x
  :straight nil
  :general (my-leader "d" #'dired-jump))

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after (all-the-icons)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package async)

(use-package dired-async
  :straight nil
  :after (dired async)
  :hook (dired-mode . dired-async-mode))


(provide 'init-dired)

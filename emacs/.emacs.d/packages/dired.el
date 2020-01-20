(setq dired-listing-switches "-hal")
(setq dired-dwim-target t)
(setq image-dired-thumb-size 500)

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after (all-the-icons)
  :hook (dired-mode . all-the-icons-dired-mode))

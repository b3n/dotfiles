(setq dired-listing-switches "-hal")

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after (all-the-icons)
  :hook (dired-mode . all-the-icons-dired-mode))

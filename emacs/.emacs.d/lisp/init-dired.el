(use-package dired
  :straight f
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches "-hal")
  (dired-dwim-target t))

(use-package image-dired
  :straight f
  :custom
  (image-dired-thumb-size 500))

(use-package dired-x
  :straight f
  :general (my-leader-def
             "f d" #'dired-jump))

(use-package all-the-icons)

(use-package all-the-icons-dired
  :after (all-the-icons)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package async)

(use-package dired-async
  :straight f
  :after (dired async)
  :hook (dired-mode . dired-async-mode))

(use-package dired-subtree
  :after dired
  :custom
  (dired-subtree-use-backgrounds nil)
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<C-tab>" . dired-subtree-cycle)
              ("<S-iso-lefttab>" . dired-subtree-remove)))

(provide 'init-dired)

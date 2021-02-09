(use-package dired
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :custom
  (dired-listing-switches "-hal")
  (dired-dwim-target t))


(use-package dired-x)


(use-package image-dired
  :custom
  (image-dired-thumb-size 500))


(use-package dired-async
  :if (eq window-system 'x)
  :after dired
  :init (use-package async :straight t)
  :hook (dired-mode . dired-async-mode))


;;(use-package browse-url
;;  :init
;;  (defun my/browse-url-xdg-open (url &optional ignored)
;;    (browse-url-xdg-open (replace-regexp-in-string "%20" "\\\\ " url)))
;;
;;  :custom
;;  (browse-url-handlers '(("\\`file:" . my/browse-url-xdg-open))))


(provide 'init-dired)

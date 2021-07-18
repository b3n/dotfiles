;; OpenBSD config
(setq evil-lookup-func (lambda () (call-interactively #'man)))


(use-package openwith
  :straight t

  :config
  (openwith-mode t)

  (setq openwith-associations
   `((,(openwith-make-extension-regexp
        '("mpg" "mpeg" "mp3" "mp4" "avi" "wmv" "wav" "mov" "flv"
          "ogm" "ogg" "mkv"))
      "mpv"
      (file)))))


(use-package pdf-tools
  :straight t

  :custom
  (pdf-view-display-size 'fit-height)

  :config
  (pdf-loader-install))


(use-package pdf-view-restore
  :straight t
  :after pdf-tools

  :custom
  (pdf-view-restore-filename (expand-file-name "pdf-view-restore" user-emacs-directory))

  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))


(provide 'berkeley-unix)

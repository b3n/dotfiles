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


(provide 'berkeley-unix)

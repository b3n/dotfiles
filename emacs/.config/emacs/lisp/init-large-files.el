(use-package so-long
  :config
  (global-so-long-mode 1))


(use-package vlf
  :straight t

  :custom
  (vlf-application 'dont-ask)

  :config
  (require 'vlf-setup))


(use-package openwith
  :straight t

  :custom
  (openwith-associations
   `((,(openwith-make-extension-regexp
        '("mpg" "mpeg" "mp3" "mp4" "avi" "wmv" "wav" "mov" "flv"
          "ogm" "ogg" "mkv"))
      "mpv"
      (,file))))

  :config
  (openwith-mode t))


(provide 'init-large-files)

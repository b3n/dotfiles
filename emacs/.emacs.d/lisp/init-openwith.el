(use-package openwith
  :config
  (openwith-mode t)
  (customize-set-variable 'openwith-associations
      `((,(openwith-make-extension-regexp '("mkv" "mp4" "mp3" "avi" "m4v" "wmv" "mov"))
         "mpv"
         (file)))))


(provide 'init-openwith)

(use-package openwith
  :straight t

  :custom
  (openwith-associations ((lambda (asocs)
                            (cl-loop for (prog . exts) in asocs
                                     collect (list (concat "\\." (regexp-opt exts) "\\'") prog '(file))))
                          '(("mpv" . ("mkv" "mp4" "mp3" "avi" "m4v" "wmv" "mov")))))
  :config
  (openwith-mode t))


(provide 'init-openwith)

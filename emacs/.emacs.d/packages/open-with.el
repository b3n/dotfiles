(use-package openwith
  :custom
  (openwith-associations ((lambda (asocs)
                            (cl-loop for (prog . exts) in asocs
                                     collect (list (concat "\\." (regexp-opt exts) "\\'") prog '(file))))
                          '(("mpv" . ("mkv" "mp4" "mp3"))
                            ("zathura" . ("pdf" "djvu" "epub" "ps")))))
  :config
  (openwith-mode t))

(use-package openwith
  :custom
  ;; TODO: Use openwith-make-extension-regexp function 
  (openwith-associations ((lambda (asocs)
                            (cl-loop for (prog . exts) in asocs
                                     collect (list (concat "\\." (regexp-opt exts) "\\'") prog '(file))))
                          '(("mpv" . ("mkv" "mp4" "mp3" "avi" "m4v" "wmv"))
                            ("zathura" . ("pdf" "djvu" "epub" "ps")))))
  :config
  (openwith-mode t))

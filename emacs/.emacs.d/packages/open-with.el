(use-package openwith
  :custom
  (openwith-associations ((lambda (asocs)
                            (cl-loop for (prog . exts) in asocs
                                     collect (list (concat "\\." (regexp-opt exts) "\\'") prog '(file))))
                          '(("mpv" . ("mkv" "mp4")))))
  :config
  (openwith-mode t))

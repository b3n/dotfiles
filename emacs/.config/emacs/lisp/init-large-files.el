(use-package so-long
  :config
  (global-so-long-mode 1))


(use-package vlf
  :straight t

  :custom
  (vlf-application 'dont-ask)

  :config
  (require 'vlf-setup))


(provide 'init-large-files)

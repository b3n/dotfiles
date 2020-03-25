(use-package vlf
  :after dired
  :custom (vlf-application 'dont-ask)
  :config (require 'vlf-setup))

(use-package minions
  :config (minions-mode 1))

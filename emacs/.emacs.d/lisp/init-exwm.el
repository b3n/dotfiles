(use-package exwm
  :if (eq window-system 'x)

  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  :custom
  (exwm-randr-workspace-monitor-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)

  :config
  (menu-bar-mode -1)

  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
   'exwm-randr-screen-change-hook
   (lambda ()
     (start-process-shell-command
      "xrandr" nil "xrandr --output DP-1 --auto --output HDMI-2 --auto --right-of DP-1"
      )))
  (exwm-randr-enable)

  ;;(my-leader-def
  ;;  "C-z" '((lambda () (interactive) (shell-command "slock")) :which-key "Sleep")
  ;;  "C-x" '((lambda () (interactive) (shell-command "xrandr --output HDMI-2 --auto")) :which-key "Screen on"))

  (require 'exwm-config)
  (exwm-config-misc)

  (exwm-enable))


(provide 'init-exwm)

(use-package exwm
  :if (eq window-system 'x)

  :init
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  (fringe-mode 1)

  (setq mouse-autoselect-window t
        focus-follows-mouse t)

  (setq display-time-default-load-average nil
        display-time-day-and-date t
        display-time-24hr-format t)
  (display-time-mode t)

  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  :custom
  (exwm-randr-workspace-output-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)

  :config
  (setq mouse-autoselect-window t
        focus-follows-mouse t)

  (push ?\M-\s  exwm-input-prefix-keys)
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command
               "xrandr" nil "xrandr --output DP-1 --auto --output HDMI-2 --auto --right-of DP-1")))
  (exwm-randr-enable)

  (require 'exwm-config)
  (exwm-config-misc)
  
  (exwm-enable))


(use-package exwm-edit
  :general (my-leader-def "E" #'exwm-edit--compose))

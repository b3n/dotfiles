(use-package exwm
  :if (eq window-system 'x)

  :init
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq frame-inhibit-implied-resize t)

  (fringe-mode 1)

  (setq
    display-time-default-load-average nil
    display-time-day-and-date t
    display-time-24hr-format t
  )
  (display-time-mode t)

  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  :custom
  (exwm-randr-workspace-output-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-global-keys '(
    ([?\s-m] . winum-select-window-1)
    ([?\s-,] . winum-select-window-2)
    ([?\s-.] . winum-select-window-3)
    ([?\s-n] . winum-select-window-4)
    ([?\s-e] . winum-select-window-5)
    ([?\s-i] . winum-select-window-6)
    ([?\s-l] . winum-select-window-7)
    ([?\s-u] . winum-select-window-8)
    ([?\s-y] . winum-select-window-9)
    ([?\s-p] . counsel-linux-app)
    ([?\s-b] . ivy-switch-buffer)
  ))

  :config
  (menu-bar-mode -1)

  (push ?\M-\s exwm-input-prefix-keys)
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
    'exwm-randr-screen-change-hook
    (lambda ()
      (start-process-shell-command
        "xrandr" nil "xrandr --output DP-1 --auto --output HDMI-2 --auto --right-of DP-1"
  )))
  (exwm-randr-enable)

  (require 'exwm-config)
  (exwm-config-misc)

  (exwm-enable)
)


(use-package exwm-edit
  :general (my-leader-def "E" #'exwm-edit--compose))

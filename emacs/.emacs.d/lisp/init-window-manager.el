(use-package exwm
  :if (eq window-system 'x)
  :straight t

  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  :custom
  ;;(exwm-randr-workspace-monitor-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([?\s-w] . exwm-workspace-switch)
     (,(kbd "s-<tab>") . tab-bar-switch-to-next-tab)
     ,@(mapcar (lambda (i) `(,(kbd (format "s-%d" i)) . tab-bar-select-tab)) (number-sequence 0 9))))

  :config
  (push ?\M-\s exwm-input-prefix-keys)

  ;;(require 'exwm-randr)
  ;;(add-hook
  ;; 'exwm-randr-screen-change-hook
  ;; (lambda ()
  ;;   (start-process-shell-command
  ;;    "xrandr" nil "xrandr --output DP-1 --auto --output HDMI-2 --auto --right-of DP-1"
  ;;    )))
  ;;(exwm-randr-enable)

  (require 'exwm-config)
  (exwm-config-misc)

  (exwm-enable))


(use-package time
  :custom
  (display-time-format "%F %R")
  (display-time-default-load-average nil)

  :config
  (display-time-mode t))


(provide 'init-window-manager)

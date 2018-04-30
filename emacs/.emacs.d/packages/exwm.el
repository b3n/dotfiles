(use-package exwm
  :if (eq window-system 'x)
  :init
  (setq mouse-autoselect-window t
        focus-follows-mouse t)

  :custom
  (exwm-input-simulation-keys
   (append
    '(([?\C-d] . [next])
      ([?\C-u] . [prior]))
    (cl-loop for c from ?a to ?z
             collect `(,(kbd (concat "s-" (string c))) . ,(kbd (concat "C-" (string c)))))))
  (exwm-layout-show-all-buffers t)
  (exwm-randr-workspace-output-plist '(1 "DVI-1"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)

  :config
  (exwm-input-set-key (kbd "<f5> R") #'exwm-reset)
  
  (require 'exwm-randr)
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command
               "xrandr" nil "xrandr --output DVI-1 --right-of DVI-0 --auto")))
  (exwm-randr-enable)
  
  (add-hook 'exwm-update-class-hook  
            (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  (add-hook 'exwm-init-hook
            (lambda ()
              (setq display-time-default-load-average nil)
              (setq display-time-day-and-date t)
              (setq display-time-24hr-format t)
              (display-time-mode t)))

  (require 'exwm-config)
  (exwm-config-misc)

  (exwm-enable))

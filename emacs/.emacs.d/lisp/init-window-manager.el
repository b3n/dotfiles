(use-package exwm
  :if (eq window-system 'x)
  :straight t

  :init
  (defun my-exwm-set-buffer-name ()
    "Add the application's class name to the buffer name."
    (exwm-workspace-rename-buffer (concat "*EXWM*<" exwm-class-name ">")))

  :hook (exwm-update-class . my-exwm-set-buffer-name)

  :init
  (setq focus-follows-mouse t)
  (setq mouse-autoselect-window t)

  :custom
  (exwm-randr-workspace-monitor-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-simulation-keys
   '(([?\s-x] .  [?\C-x])
     ([?\s-c] .  [?\C-c])
     ([?\s-w] .  [?\C-w])
     ([?\s-a] .  [?\C-a])
     ([?\s-v] .  [?\C-v])))
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([?\s-o] . exwm-workspace-swap)
     ([?\s-p] . (lambda (command)
                  (interactive (list (read-shell-command "$ ")))
                  (start-process-shell-command command nil (concat "nohup " command))))
     ([?\s-g] . (lambda () (interactive) (shell-command "xrandr --output HDMI-2 --auto")))
     (,(kbd "s-<tab>") . tab-bar-switch-to-next-tab)
     ,@(mapcar (lambda (i) `(,(kbd (format "s-%d" i)) . tab-bar-select-tab)) (number-sequence 0 9))))

  :config
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
   'exwm-randr-screen-change-hook
   (lambda ()
     (start-process-shell-command
      "xrandr" nil "xrandr --output HDMI-2 --auto --output DP-1 --auto --right-of HDMI-2")))
  (exwm-randr-enable))


(use-package time
  :custom
  (display-time-format "%R")
  (display-time-default-load-average nil)

  :config
  (display-time-mode t)
  (add-to-list
   'global-mode-string
   '(:eval (propertize " " 'display `((space :align-to (- right ,(1+ (length display-time-string)))))))))


(provide 'init-window-manager)

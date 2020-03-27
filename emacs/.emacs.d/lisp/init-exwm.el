(use-package modus-vivendi-theme ;; Dark
  :if (eq (system-name) "beastie")
  :custom
  (modus-vivendi-theme-slanted-constructs t)
  (modus-vivendi-theme-bold-constructs t)
  (modus-vivendi-theme-scale-headings t)

  :config
  (load-theme 'modus-vivendi t))


(use-package exwm
  :if (eq (system-name) "beastie")

  :init
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (setq frame-inhibit-implied-resize t)
  (fringe-mode 1)

  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

  :custom
  (exwm-randr-workspace-output-plist '(1 "HDMI-2"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-global-keys
   (loop for c from ?a to ?z collect
         (cons
          (kbd (format "s-%c" c))
          (lookup-key (current-global-map) (kbd (format "C-c %c" c))))))

  :config
  (menu-bar-mode -1)

  ;;(push ?\M-\s exwm-input-prefix-keys)
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
    'exwm-randr-screen-change-hook
    (lambda ()
      (start-process-shell-command
        "xrandr" nil "xrandr --output DP-1 --auto --output HDMI-2 --auto --right-of DP-1"
  )))
  (exwm-randr-enable)

(my-leader-def
  "C-z" '((lambda () (interactive) (shell-command "slock")) :which-key "Sleep")
  "C-x" '((lambda () (interactive) (shell-command "xrandr --output HDMI-2 --auto")) :which-key "Screen on"))

  (require 'exwm-config)
  (exwm-config-misc)

  (exwm-enable))


(use-package exwm-edit
  :general (my-leader-def "E" #'exwm-edit--compose))


(provide 'init-exwm)

;; Things a text editor has no buisness doing. ;-)

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
  (exwm-randr-workspace-monitor-plist '(1 "HDMI2"))
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
     ([?\s-b] . switch-to-buffer)
     ([?\s-p] . (lambda (command)
                  (interactive (list (read-shell-command "$ ")))
                  (start-process-shell-command command nil (concat "nohup " command))))
     ([?\s-g] . (lambda () (interactive) (shell-command "xrandr --output HDMI2 --auto")))
     (,(kbd "s-<tab>") . tab-bar-switch-to-next-tab)
     ,@(mapcar (lambda (i) `(,(kbd (format "s-%d" i)) . tab-bar-select-tab)) (number-sequence 0 9))))

  :config
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (add-hook
   'exwm-randr-screen-change-hook
   (lambda ()
     (start-process-shell-command
      "xrandr" nil "xrandr --output HDMI2 --auto --output DP1 --auto --right-of HDMI2")))
  (exwm-randr-enable))


(use-package time
  :custom
  (display-time-format "%F %R")
  (display-time-default-load-average nil)

  :config
  (display-time-mode t))


(use-package emms
  :straight t

  :bind (("s-," . emms-previous)
         ("s-." . emms-next)
         ("s-m" . emms-pause))

  :custom
  (emms-source-file-default-directory "/mnt/sandisk/music")

  :config
  (require 'emms-setup)
  ;; (emms-all)
  (emms-default-players)
  (require 'emms-mode-line)
  (emms-mode-line 1))


(use-package calc
  :bind ("C-c c" . calc-dispatch)

  :config
  ;; Get latest exchange rates
  (with-current-buffer (url-retrieve-synchronously "https://api.openrates.io/latest")
    (let* ((exch (json-read))
           (base (intern (cdr (assq 'base exch)))))
      (setq math-additional-units
            (cons
             (list base nil "Base currency")
             (cl-loop for (curr . rate) in (cdr (assq 'rates exch))
                      collect (list curr (format "%f %s" (/ rate) base)
                                    (format "Currency %s in terms of %s" curr base))))
            math-units-table nil)))

  (add-to-list 'math-tzone-names '("AEST" -10 0)))


(use-package erc
  :config
  (setq erc-lurker-hide-list '("JOIN" "PART" "QUIT")
        erc-lurker-threshold-time 3600)
  (setq erc-join-buffer 'bury)
  (setq erc-nick "Ben`")
  (setq erc-format-query-as-channel-p t
        erc-track-priority-faces-only 'all
        erc-track-faces-priority-list '(erc-error-face
                                        erc-current-nick-face
                                        erc-keyword-face
                                        erc-nick-msg-face
                                        erc-direct-msg-face
                                        erc-dangerous-host-face
                                        erc-notice-face
                                        erc-prompt-face)))


(provide 'init-operating-system)

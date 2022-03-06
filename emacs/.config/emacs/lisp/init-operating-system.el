;; Things a text editor has no buisness doing. ;-)

(use-package exwm
  :if (eq window-system 'x)
  :straight t

  :init
  (setq focus-follows-mouse t)

  (defun my/exwm-set-buffer-name ()
    "Make a nicer title and file name for the buffer"

    (setq-local exwm-title
                (concat
                 exwm-class-name
                 "<"
                 (if (<= (length exwm-title) 160)
                     exwm-title
                   (concat (substring exwm-title 0 150) "…"))
                 ">"))

    (exwm-workspace-rename-buffer exwm-title))

  (defun my/gtk-launch ()
    "Launch an X application via `gtk-launch'."
    (interactive)
    (require 'xdg)
    (let* ((extention "\\.desktop$")
           (dirs (mapcar (lambda (dir) (expand-file-name "applications" dir))
                         (cons (xdg-data-home) (xdg-data-dirs))))
           (apps (cl-loop for dir in dirs
                          if (file-exists-p dir)
                          append (cl-loop for file in (directory-files dir nil extention)
                                          collect (replace-regexp-in-string extention "" file)))))
      (call-process "gtk-launch" nil 0 nil (completing-read "Launch: " apps))))

  (defun my/exwm-buffer-settings ()
    (setq-local left-fringe-width 0)
    (setq-local right-fringe-width 0))

  :hook (((exwm-update-class exwm-update-title) . my/exwm-set-buffer-name)
         (exwm-mode . my/exwm-buffer-settings))

  :custom
  (exwm-randr-workspace-monitor-plist '(0 "HDMI-2" 1 "DP-1"))
  (exwm-workspace-number 2)
  (exwm-workspace-show-all-buffers t)
  (exwm-layout-show-all-buffers t)
  (exwm-input-simulation-keys
   `(([?\s-x] .  [?\C-x])
     ([?\s-c] .  [?\C-c])
     ([?\s-w] .  [?\C-w])
     ([?\s-a] .  [?\C-a])
     ([?\s-f] .  [?\C-f])
     ([?\s-l] .  [?\C-l])
     ([?\s-n] .  [?\C-n])
     ([?\s-o] .  [?\C-o])
     ([?\C-y] .  [?\C-v])
     ([?\C-a] .  [?\C-a])
     ([?\s-/] .  [?\C-f]) ;; Chrome search
     ([?\s-b] .  ,(kbd "C-S-a")) ;; Chrome switch tab with search
     ([?\s-v] .  [?\C-v])))
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([?\s-o] . exwm-workspace-swap)
     ([?\s-\s] . my/gtk-launch)))

  :config
  (scroll-bar-mode 0)
  (horizontal-scroll-bar-mode 0)
  (push ?\C-w exwm-input-prefix-keys)

  (require 'exwm-randr)
  (exwm-randr-enable))


(use-package time
  :after exwm

  :custom
  (display-time-format "%F %R\t")
  (display-time-default-load-average nil)

  :config
  (display-time-mode t))


(use-package emms
  :straight t
  :bind ("C-c m" . emms)

  :custom
  (emms-source-file-default-directory "/mnt/sandisk/music")
  (emms-volume-change-function
   (lambda (amount)
     (call-process "sndioctl" nil nil nil
      (format "app/mpv0.level=%s%s" (if (> amount 0) "+" "") (/ amount 10.0)))))

  :config
  (require 'emms-setup)
  (require 'emms-mode-line)
  (require 'emms-volume-mixerctl)
  (emms-all)
  (emms-default-players)
  (emms-mode-line 1))


(use-package midnight
  :config
  (midnight-mode))


(use-package emacs
  :config
  (defun my-same-mode-next-buffer ()
    "Select next buffer of the same type"
    (interactive)
    (let ((new-buffer (car (my--same-mode-buffer-list))))
      (when new-buffer
        (bury-buffer)
        (switch-to-buffer new-buffer))))


  (defun my-same-mode-previous-buffer ()
    "Select previous buffer of the same type"
    (interactive)
    (let ((new-buffer (car (last (my--same-mode-buffer-list)))))
      (when new-buffer (switch-to-buffer new-buffer))))


  (defun my--same-mode-buffer-list (&optional mode)
    "List buffers of mode `mode' that are not already visible"
    (let ((mode (or mode major-mode)))
      (seq-filter (lambda (buffer) 
                    (and (not (get-buffer-window buffer 'visible))
                         (eq (buffer-local-value 'major-mode buffer) mode)))
                  (buffer-list))))

  (global-set-key [mode-line mouse-4] #'my-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'my-same-mode-next-buffer))


(use-package erc
  :config
  (erc-spelling-mode)
  :custom
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 14)
  (erc-fill-column (- (/ (frame-width) 2) 3))
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-auto-query 'bury)
  (erc-kill-server-buffer-on-quit t)
  (erc-kill-queries-on-quit t)
  (erc-kill-buffer-on-part t)
  (erc-disable-ctcp-replies t)
  (erc-prompt (lambda nil (format "%s>" (buffer-name))))
  (erc-user-mode "+iR")
  (erc-server "irc.libera.chat")
  (erc-port "6697"))


(provide 'init-operating-system)

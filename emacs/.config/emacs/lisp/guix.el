;;; guix.el --- Ben's Linux configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This extends my configuration for use at home, where I'm running GNU GUIX and using
;; EXWM as my window manager.

;;; Code:

(require 'my-helpers)


;;; Miscellaneous (to be categorised)

(with-eval-after-load 'tex
  (my-use auctex)
  (setq latex-run-command "pdflatex"
        TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil
        TeX-PDF-mode t
        TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
        TeX-source-correlate-start-server t)
  (setq doc-view-continuous t)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))


;;; Applications

(with-eval-after-load 'erc
  (setq erc-fill-function 'erc-fill-static
        erc-fill-static-center 14
        erc-fill-column (- (/ (frame-width) 2) 3)
        erc-hide-list '("JOIN" "PART" "QUIT")
        erc-auto-query 'bury
        erc-kill-server-buffer-on-quit t
        erc-kill-queries-on-quit t
        erc-kill-buffer-on-part t
        erc-disable-ctcp-replies t
        erc-prompt (lambda () (format "%s>" (buffer-name)))
        erc-user-mode "+iR"
        erc-server "irc.libera.chat"
        erc-port "6697")
  (erc-spelling-mode))


;;; X11 window manager

(when (eq window-system 'x)
(my-use 'exwm
  ;;(require 'exwm-randr)

  (defun my-exwm-set-buffer-name ()
    "Make a nicer title and file name for the buffer"

    (setq-local exwm-title
                (concat
                 exwm-class-name
                 "<"
                 (if (<= (length exwm-title) 120)
                     exwm-title
                   (concat (substring exwm-title 0 100) "…"))
                 ">"))

    (exwm-workspace-rename-buffer exwm-title))

  (defun my-gtk-launch ()
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

  ;; (defun my-exwm-buffer-settings ()
  ;;   (setq-local left-fringe-width 0
  ;;               right-fringe-width 0))

  ;; (add-hook 'exwm-mode-hook #'my-exwm-buffer-settings)
  (add-hook 'exwm-update-class-hook #'my-exwm-set-buffer-name)
  (add-hook 'exwm-update-title-hook #'my-exwm-set-buffer-name)

  (setq exwm-randr-workspace-monitor-plist '(0 "HDMI-2" 1 "DP-1")
        exwm-workspace-number 2
        exwm-workspace-show-all-buffers t
        exwm-layout-show-all-buffers t
        focus-follows-mouse t
        menu-bar-mode nil
        scroll-bar-mode nil)
  (setq exwm-input-simulation-keys
        `(([?\C-a] .  [?\C-a])
          ([?\C-y] .  [?\C-v])
          ([?\s-a] .  [?\C-a])
          ([?\s-c] .  [?\C-c])
          ([?\s-f] .  [?\C-f])
          ([?\s-l] .  [?\C-l])
          ([?\s-n] .  [?\C-n])
          ([?\s-o] .  [?\C-o])
          ([?\s-v] .  [?\C-v])
          ([?\s-w] .  [?\C-w])
          ([?\s-x] .  [?\C-x])))
  (setq exwm-input-global-keys
        `(([?\s-r] . exwm-reset)
          ([?\s-o] . exwm-workspace-swap)
          ([?\s-\s] . my-gtk-launch)))

  (with-eval-after-load 'evil
    (add-to-list 'evil-insert-state-modes 'exwm))

  (add-to-list 'exwm-input-prefix-keys ?\C-w)

  (setq display-time-format "%F %R\t")
  (display-time-mode)

  ;;(exwm-randr-enable)
  (exwm-enable))


(provide 'guix)

;;; home.el ends here

;;; -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'seq)


;; http://camdez.com/blog/2013/11/14/emacs-show-buffer-file-name/
(defun my-show-buffer-file-name ()
  "Show the full path to the current file in the minibuffer."

  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))


(defun my-use-package-initialize ()
  "Install/configure use-package and dependencies."
  
  (require 'package)
  (setq package-archives
        '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
          ("MELPA Stable" . "https://stable.melpa.org/packages/")
          ("MELPA"        . "https://melpa.org/packages/"))
        package-archive-priorities
        '(("MELPA Stable" . 5)
          ("GNU ELPA"     . 9)
          ("MELPA"        . 1)))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile (require 'use-package))
  (setq use-package-always-ensure t)
  (use-package general))


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


(defun my-read-file (filepath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

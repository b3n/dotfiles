;;; -*- lexical-binding: t -*-

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
          ("MELPA"        . "https://melpa.org/packages/")
          ("ORG"          . "https://orgmode.org/elpa/"))
        package-archive-priorities
        '(("MELPA Stable" . 10)
          ("ORG"          . 6)
          ("GNU ELPA"     . 5)
          ("MELPA"        . 0)))
  (package-initialize)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile (require 'use-package))
  (setq use-package-always-ensure t)

  (use-package diminish)
  (use-package general))


(require 'cl-lib)
(require 'seq)

(defun my-mode-next-buffer ()
  (interactive)
  (my--mode-buffer #'next-buffer))

(defun my-mode-previous-buffer ()
  (interactive)
  (my--mode-buffer #'previous-buffer))

(defun my--mode-buffer (buffer-change-function)
  (let ((orig-window-next-buffers (symbol-function #'window-next-buffers))
        (orig-window-prev-buffers (symbol-function #'window-prev-buffers))
        (orig-buffer-list (symbol-function #'buffer-list)))
    (cl-letf* (((symbol-function #'filter) (lambda (f)
                                             (lambda (&rest args)
                                               (my--mode-filter-buffers (apply f args)))))
               ((symbol-function #'window-next-buffers) (filter orig-window-next-buffers))
               ((symbol-function #'window-prev-buffers) (filter orig-window-prev-buffers))
               ((symbol-function #'buffer-list) (filter orig-buffer-list)))
      (call-interactively buffer-change-function))))

(defun my--mode-filter-buffers (buffers &optional mode)
  (let ((mode (or mode major-mode)))
    (seq-filter
     (lambda (b) (and (bufferp b) (string= (buffer-local-value 'major-mode b) mode)))
     buffers)))

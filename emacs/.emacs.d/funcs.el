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

  (defvar bootstrap-version)
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  (straight-use-package 'use-package)
  (setq straight-use-package-by-default t)
  (use-package diminish)
  (use-package general)

  ;; Below is a hack to make org-mode work nicely
  (require 'subr-x)
  (straight-use-package 'git)
  (defun org-git-version ()
    "The Git version of org-mode.
Inserted by installing org-mode or when a release is made."
    (require 'git)
    (let ((git-repo (expand-file-name
                     "straight/repos/org/" user-emacs-directory)))
      (string-trim
       (git-run "describe"
                "--match=release\*"
                "--abbrev=6"
                "HEAD"))))
  (defun org-release ()
    "The release version of org-mode.
Inserted by installing org-mode or when a release is made."
    (require 'git)
    (let ((git-repo (expand-file-name
                     "straight/repos/org/" user-emacs-directory)))
      (string-trim
       (string-remove-prefix
        "release_"
        (git-run "describe"
                 "--match=release\*"
                 "--abbrev=0"
                 "HEAD")))))
  (provide 'org-version)
  (straight-use-package 'org-plus-contrib))


(defun my--same-mode-buffer-list (&optional mode)
  "List buffers of mode `mode' that are not already visible"
  (let ((mode (or mode major-mode)))
    (seq-filter (lambda (buffer) 
                  (and (not (get-buffer-window buffer 'visible))
                       (eq (buffer-local-value 'major-mode buffer) mode)))
                (buffer-list))))

(defun my-same-mode-next-buffer ()
  "Select next buffer of the same type"
  (interactive)
  (let ((new-buffer (car (my--same-mode-buffer-list))))
    (bury-buffer)
    (switch-to-buffer new-buffer)))

(defun my-same-mode-previous-buffer ()
  "Select previous buffer of the same type"
  (interactive)
  (let ((new-buffer (car (last (my--same-mode-buffer-list)))))
    (switch-to-buffer new-buffer)))

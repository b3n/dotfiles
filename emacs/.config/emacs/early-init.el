;;; early-init.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; The initiation of the initiation.  This file is loaded before the package
;; system and GUI are initialised.  See also: `init.el'.

;;; Code:

(require 'cl-macs)
(require 'package)


;;; Basic settings

(setq create-lockfiles nil)
(setq fast-but-imprecise-scrolling t)
(setq frame-inhibit-implied-resize t)
(setq frame-title-format '("%b — %F"))
(setq history-delete-duplicates t)
(setq history-length 1000)
(setq mouse-autoselect-window t)
(setq visible-bell t)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default indicate-buffer-boundaries 'right)
(setq-default tab-width 4)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;;; Helpers for package configuration

(defvar my-uninstalled-packages nil
  "List of packages configured with `after' that have not been installed.

These can be installed via `my-install-uninstalled-packages'.")

(defmacro after (package &optional trigger &rest body)
  "Call TRIGGER function from PACKAGE, and eval BODY after load.

The idea is that TRIGGER sets up a trigger (e.g. a binding or hook) to load the
PACKAGE, and once loaded BODY is executed.

TRIGGER can be a function, or elisp expression. If it is a function, it is
passed the package symbol as its argument (useful for `require'). It should
return non-nil if the trigger is successfully setup, and nil or error otherwise.

Note that this does not install packages. If the package is not installed, it is
added to `my-uninstalled-packages' for manual installation."
  (declare (indent defun))
  `(progn
     (unless (or (ignore-errors ,(if (functionp trigger) `(funcall ',trigger ',package) trigger))
                 ;;(featurep ',package)
                 (package-installed-p ',package))
       (add-to-list 'my-uninstalled-packages ',package)
       (display-warning 'my-emacs (format "Package `%s' is not installed" ',package)))
     (with-eval-after-load ',package ,@body)))

(defun my-install-uninstalled-packages ()
  "Install all packages in `my-uninstalled-packages'."
  (interactive)
  (package-refresh-contents)
  (mapc #'my--package-install my-uninstalled-packages)
  (setq my-uninstalled-packages
        (seq-remove #'package-installed-p my-uninstalled-packages)))

(defun my--package-install (package)
  "Install PACKAGE.

Install from local `packages/' directory if it exists, else install from a
remote package archive."
  (let ((package-file (expand-file-name (format "packages/%s.el" package)
                                        user-emacs-directory)))
    (if (file-exists-p package-file)
        (package-install-file package-file)
      (package-install package))))

;;TODO: Simplify this, as it only needs to support two arguments
(defmacro setc (&rest defs)
  "Set DEFS, like `setq', but using `customize-set-variable'."
  `(progn
     ,@(cl-loop for (var def) on defs by 'cddr
                collect `(customize-set-variable ',var ,def))))

(defmacro bind (mode &rest defs)
  "Define key DEFS in MODE."
  (declare (indent defun))
  `(commandp ;; Return value so it can be used as `TRIGGER' in `after'
    (progn
     ,@(cl-loop for (key def) on defs by 'cddr
                collect `(define-key ,(intern (format "%s-map" mode))
                           ,(if (stringp key) (kbd key) key)
                           #',def)))))


(provide 'early-init)

;;; early-init.el ends here

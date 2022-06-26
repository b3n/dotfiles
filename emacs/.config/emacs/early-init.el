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
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)
(setq mouse-autoselect-window t)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default indicate-buffer-boundaries 'right)
(setq-default tab-width 4)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;;; Helpers for package configuration

(defvar my-uninstalled-packages nil
  "List of packages configured with `after' that have not been installed.

These can be installed via `my-install-uninstalled-packages'.")

(defmacro cfg (package &optional trigger &rest body)
  "Call TRIGGER function from PACKAGE, and eval BODY after load.

The idea is that TRIGGER sets up a trigger (e.g. a binding or hook) to load the
PACKAGE, and once loaded BODY is executed.

TRIGGER can be a function, or elisp expression. If it is a function, it is
passed the package symbol as its argument (useful for `require'). It should
return non-nil if the package is installed, and nil or error otherwise.

Note that this does not install packages. If the package is not installed, it is
added to `my-uninstalled-packages' for manual installation."
  (declare (indent defun))
  `(progn
     (unless (or (ignore-errors ,(if (functionp trigger)
                                     `(funcall ',trigger ',package)
                                   trigger))
                 (featurep ',package)
                 (package-installed-p ',package))
       (add-to-list 'my-uninstalled-packages ',package)
       (message "Package `%s' is not installed" ',package))
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

(defmacro setc (sym val)
  "Set SYM to VAL.

like `setq', but using `customize-set-variable'."
  `(customize-set-variable ',sym ,val))

(defmacro bind (mode &rest defs)
  "Define key DEFS in MODE."
  (declare (indent defun))
  `(progn
     ,@(cl-loop for (key def) on defs by 'cddr
                collect `(when (commandp #',def)
                           (define-key
                             ,(intern (format "%s-map" mode))
                             ,(if (stringp key) (kbd key) key)
                             #',def)))))

(defmacro auto-mode (ext mode)
  "Use mode MODE for files with extension EXT."
  `(when (commandp #',mode)
     (add-to-list 'auto-mode-alist '(,(format "\\.%s\\'" ext) . ,mode))))

(defmacro hook (mode fun &optional depth local)
  "Add function FUN to MODE's hook."
  `(when (functionp #',fun)
     (add-hook ',(intern (format "%s-hook" mode)) #',fun ,depth ,local)))


(provide 'early-init)

;;; early-init.el ends here

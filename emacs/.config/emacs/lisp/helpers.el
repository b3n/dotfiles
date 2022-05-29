;;; helpers.el --- Helper macros for Emacs configuration  -*- lexical-binding: t -*-

;;; Commentary:

;; A collection of small helper macros.

;;; Code:

(require 'cl-macs)
(require 'package)

(defmacro bind (mode &rest defs)
  "Define key DEFS in MODE."
  (declare (indent defun))
  `(progn
     ,@(cl-loop for (key def) on defs by 'cddr
                collect `(define-key ,(intern (format "%s-map" mode))
                           ,(if (stringp key) (kbd key) key)
                           #',def))))

(defmacro after (package &rest body)
  "Install PACKAGE if needed, then eval the BODY /after/ load."
  (declare (indent defun))
  `(progn
     (unless (or (featurep ',package) (package-installed-p ',package))
       (or (ignore-errors (package-install-file
                           ,(expand-file-name
                            ;;TODO: Rename `lisp' and remove from `load-path'
                            (format "lisp/%s.el" package)
                            user-emacs-directory)))
           (ignore-errors (package-install ',package t))))
     (with-eval-after-load ',package ,@body)))

(defmacro setc (&rest defs)
  "Set DEFS, like `setq', but using `customize-set-variable'."
  `(progn
     ,@(cl-loop for (var def) on defs by 'cddr
                collect `(customize-set-variable ',var ,def))))

(provide 'helpers)

;;; helpers.el ends here

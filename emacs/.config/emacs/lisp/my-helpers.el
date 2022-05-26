(require 'cl-macs)
(require 'package)

(setq custom-file (make-temp-file "emacs-custom-"))

(defmacro my-key (mode &rest defs)
  "Helper for defining keys DEFS in MODE."
  (declare (indent defun))
  `(progn
     ,@(cl-loop for (key def) on defs by 'cddr
                collect `(define-key ,(intern (format "%s-map" mode))
                           ,(if (stringp key) (kbd key) key)
                           #',def))))

(defmacro my-use (package &rest body)
  "Install PACKAGE if needed, then eval the BODY after load."
  (declare (indent defun))
  `(progn
     (unless
         (or (featurep ,package)
             (package-installed-p ,package))
       (or (ignore-errors (package-install-file
                           (expand-file-name
                            ;;TODO: Rename `lisp' and remove from `load-path'
                            (concat "lisp/" (symbol-name ,package) ".el")
                            user-emacs-directory)))
           (ignore-errors (package-install ,package t))))
     (with-eval-after-load ,package ,@body)))

(provide 'my-helpers)

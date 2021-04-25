;;; zkeleton.el  -*- lexical-binding: t; -*-

(defcustom zkeleton-prefix
  "z"
  "Prefix for abbrevs"
  :type 'string)

(defun zkeleton--add-parent-to-table (table &rest _)
  "Guesses and attempts to add the parent mode's table as a parent table."
  (let* ((table-prefix "-abbrev-table")
         (mode (intern (replace-regexp-in-string table-prefix "" (symbol-name table))))
         (mode-parent (get mode 'derived-mode-parent))
         (table-parent (intern (concat (symbol-name mode-parent) table-prefix))))
    (when (boundp table-parent)
      (abbrev-table-put (eval table)
                        :parents (cons (eval table-parent) (abbrev-table-get (eval table) :parents))))))

;; This allows us to for example use `prog-mode-abbrev-table` for all derived modes.
(advice-add 'define-abbrev-table :after #'zkeleton--add-parent-to-table)

;;;###autoload
(defmacro define-zkeletons (&optional mode &rest zkeletons)
  (declare (indent defun))
  `(progn ,@(mapcar (lambda (s) `(define-zkeleton ,(car s) ,mode ,@(cdr s))) zkeletons)))

;;;###autoload
(defmacro define-zkeleton (name &optional mode &rest skeleton)
  (declare (indent defun))
  (let* ((mode (if mode (symbol-name mode) "global"))
         (abbrev-table (intern (concat mode "-abbrev-table")))
         (zkeleton-name (concat zkeleton-prefix (symbol-name name))))
    (if (or (not skeleton) (and (= (length skeleton) 1) (stringp (car skeleton))))
        ;; We have a bone rather than a real skeleton, so just define a normal abbrev.
        `(define-abbrev ,abbrev-table ,zkeleton-name ,@skeleton nil :system t)
      (let ((func-name (intern (concat "zkeleton-" mode "-" zkeleton-name)))
            (docstring (concat zkeleton-name " zkeleton, for use in " mode))
            (skeleton (if (= (length skeleton) 1) (cons nil skeleton) skeleton)))
        `(progn
           (define-skeleton ,func-name ,docstring ,@skeleton)
           (define-abbrev ,abbrev-table ,zkeleton-name "" ',func-name :system t))))))

(setq-default abbrev-mode t) 

(define-zkeletons global
  (dd (format-time-string "%Y-%m-%d"))
  (dt (format-time-string "%Y-%m-%dT%H:%M:%S%:z"))
  (td "" comment-start " TODO: " _ comment-end))

(with-eval-after-load 'org
  (define-zkeletons org-mode
    (ti "Title: " "#+title:" str "\n")
    (ta nil "| " ("Column: " str " | ") -1 \n "|-" \n "| ")
    (tac "Captian: " "#+caption: " str \n "| " ("Column: " str " | ") -1 \n "|-" \n "| ")
    (bl "Type: " \n "#+begin_" str \n _ \n "#+end_" str \n)
    (src "Language: " \n "#+begin_src " str \n _ \n "#+end_src" \n)
    (li "Link: " "[[" str "][" (skeleton-read "Description: ") "]]")))

(define-zkeletons emacs-lisp-mode
  (def "Name: " "(defun " str " (" ("Argument: " str " ") -1 ")" \n
       > "\"" (skeleton-read "Docstring: ") "\"" \n
       > "(" _ "))"))

(provide 'init-zkeleton)

;;; zkeleton.el  -*- lexical-binding: t; -*-

(defcustom zkeleton-prefix
  "z"
  "Prefix for abbrevs"
  :type 'string)

;;;###autoload
(defmacro define-zkeletons (&optional mode &rest zkeletons)
  (declare (indent defun))
  `(progn ,@(mapcar (lambda (s) `(define-zkeleton ,(car s) ,mode ,@(cdr s))) zkeletons)))

;;;###autoload
(defmacro define-zkeleton (name &optional mode &rest skeleton)
  (declare (indent defun))
  (let* ((mode (if mode (symbol-name mode) "global"))
         (abbrev-table (intern (concat mode "-abbrev-table")))
         (skeleton-name (symbol-name name))
         (zkeleton-name (concat zkeleton-prefix skeleton-name)))
    (if (or (not skeleton) (and (= (length skeleton) 1) (stringp (car skeleton))))
        ;; We have a bone rather than a real skeleton, so just define a normal abbrev.
        `(define-abbrev ,abbrev-table ,zkeleton-name ,@skeleton nil :system t)
      (let ((func-name (intern (concat "zkeleton-" mode "-" skeleton-name)))
            (docstring (concat zkeleton-name " zkeleton, for use in " mode))
            (skeleton (if (= (length skeleton) 1) (cons nil skeleton) skeleton)))
        `(progn
           (define-skeleton ,func-name ,docstring ,@skeleton)
           (define-abbrev ,abbrev-table ,zkeleton-name "" ',func-name :system t))))))

(setq-default abbrev-mode t) 

(define-zkeletons global
  (dd (format-time-string "%Y-%m-%d"))
  (dt (format-time-string "%Y-%m-%dT%H:%M:%S%:z"))
  (td nil comment-start " TODO: " _ comment-end))

(with-eval-after-load 'org
  (define-zkeletons org-mode
    (ti "Title: " "#+title:" str "\n")
    (ta nil "| " ("Column: " str " | ") -1 \n "|-" \n "| ")
    (ca "#+caption: ")
    (bl "Type: " \n "#+begin_" str \n _ \n "#+end_" str \n)
    (src "Language: " \n "#+begin_src " str \n _ \n "#+end_src" \n)
    (li "Link: " "[[" str "][" (skeleton-read "Description: ") "]]")))

(define-zkeletons emacs-lisp-mode
  (def "Name: " "(defun " str " (" ("Argument: " str " ") -1 ")" \n
       > "\"" (skeleton-read "Docstring: ") "\"" \n
       > "(" _ "))" \n)
  (def2 nil "(defun " @ -  " (" (nil @ " ") -1 ")" \n
       > "\"" @ "\"" \n
       > "(" @ _ "))"))


(provide 'init-zkeleton)

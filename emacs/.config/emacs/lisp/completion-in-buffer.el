;;; completion-in-buffer.el -- Set completion-in-region-function  -*- lexical-binding: t -*-

;;; Commentary:

;; Use minibuffer completion UI for completion-at-point, to have a consistent UI for
;; completions everywhere.
;;
;; Inspired by: https://github.com/katspaugh/ido-at-point

;;; Code:

(require 'minibuffer)

(defun completion-in-buffer (start end col &optional pred)
  "Completion in region function utilizing `completing-read'."
  (if (minibufferp) (completion--in-region start end col pred)
    (let* ((init (buffer-substring-no-properties start end))
           (all (completion-all-completions init col pred (length init)))
           (completion (cond
                        ((atom all) nil)
                        ((and (consp all) (atom (cdr all))) (car all))
                        (t (completing-read "Completions: " col pred t init)))))
      (if completion
          (progn
            (delete-region start end)
            (insert completion)
            t)
        (message "No completions") nil))))

(setq completion-category-defaults nil)
(setq completion-in-region-function #'completion-in-buffer)


(provide 'completion-in-buffer)

;;; completion-in-buffer.el ends here

;;; minibuffer-repeat.el ---  -*- lexical-binding: t; -*-

;; Version: 0.1

;;; Commentary:

;;; Code:

(defvar minibuffer-repeat--command nil)
(defvar minibuffer-repeat--input nil)

;;;###autoload
(defun minibuffer-repeat-save ()
  (setq minibuffer-repeat--command this-command)
  (add-hook 'post-command-hook
            (lambda () (setq minibuffer-repeat--input (minibuffer-contents)))
            nil 'local))

;;;###autoload
(defun minibuffer-repeat ()
  (interactive)
  (minibuffer-with-setup-hook
      (lambda ()
        (delete-minibuffer-contents)
        (insert minibuffer-repeat--input))
    (command-execute (setq this-command minibuffer-repeat--command))))

(provide 'minibuffer-repeat)

;;; minibuffer-repeat.el ends here

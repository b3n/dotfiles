;;; password-gen.el --- Generate a password  -*- lexical-binding: t; -*-

;; Version: 0.1

;;; Commentary:

;; TODO

;;; Code:

(defcustom password-gen-command
  "~/bin/password_gen"
  "The command to generate a password"
  :type 'string)

(defcustom password-gen-length
  nil
  "The default length of passwords, or nil to ask"
  :type 'integer)

;;;###autoload
(defun password-gen (length)
  "Generate a password."
  (interactive "p")
  ;;TODO: Use `auth-sources'
  (unless (boundp 'password-gen-password)
    (setq password-gen-password (read-passwd "Master: ")))
  (let ((length (if (> length 1) length nil)))
  (gui-set-selection 'CLIPBOARD
                     (substring
                      (shell-command-to-string
                       (concat
                        password-gen-command " "
                        (shell-quote-argument password-gen-password) " "
                        (shell-quote-argument (read-passwd "Password: "))))
                      0
                      (or length password-gen-length (read-number "Length: "))))))

(provide 'password-gen)

;;; password-gen.el ends here

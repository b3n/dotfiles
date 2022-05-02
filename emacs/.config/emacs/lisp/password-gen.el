;;; password-gen.el --- Generate a password  -*- lexical-binding: t; -*-

(defcustom password-gen-command
  "~/bin/password_gen"
  "The command to generate a password"
  :type 'string)

(defcustom password-gen-length
  nil
  "The length of passwords, or nil to ask"
  :type 'integer)

;;;###autoload
(defun password-gen ()
  "Generate a password."
  (interactive)
  (unless (boundp 'password-gen-password) (setq password-gen-password (read-passwd "Master: ")))
  (gui-set-selection 'CLIPBOARD
                     (substring
                      (shell-command-to-string
                       (concat
                        password-gen-command " "
                        (shell-quote-argument password-gen-password) " "
                        (shell-quote-argument (read-passwd "Password: "))))
                      0
                      (or password-gen-length (read-number "Length: ")))))

(provide 'password-gen)

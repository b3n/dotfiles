;;; password-gen.el --- Generate a password  -*- lexical-binding: t; -*-

(defcustom password-gen-command
  "/home/ben/bin/password_gen"
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
  (let ((prev-state evil-state))
    (when (bound-and-true-p evil-mode) (evil-append 1))
    (execute-kbd-macro
     (substring
      (shell-command-to-string
       (concat
        password-gen-command " "
        (shell-quote-argument password-gen-password) " "
        (shell-quote-argument (read-passwd "Password: "))))
      0
      (or password-gen-length (read-number "Length: "))))
    (when (bound-and-true-p evil-mode) (evil-change-state prev-state))))

(global-set-key (kbd "C-c p") #'password-gen)

(provide 'init-password-gen)

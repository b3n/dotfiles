;;; Test script to use password_gen

(setq password-gen-command "/home/ben/bin/password_gen")

(defun password-gen ()
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
      (read-number "Length: ")))
    (when (bound-and-true-p evil-mode) (evil-change-state prev-state))))

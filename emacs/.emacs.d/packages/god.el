(use-package god-mode
  :config
  (defun god-mode-lookup-command (key-string)
    "Execute extended keymaps such as C-c, or if it is a command, call it."
    (let* ((key-vector (read-kbd-macro key-string t))
	   (binding (key-binding key-vector))
	   (key-string-parts (split-string key-string))
	   (key-string-last (car (last key-string-parts))))
      (cond ((commandp binding)
	     (setq last-command-event (aref key-vector (- (length key-vector) 1)))
	     binding)
	    ((keymapp binding)
	     (god-mode-lookup-key-sequence nil key-string))
	    ((string-prefix-p "C-" key-string-last)
	     (god-mode-lookup-command
	      (string-join
	       (append
		(butlast key-string-parts)
		(list (string-remove-prefix "C-" key-string-last)))
	       " ")))
	    (:else
	     (error "God: Unknown key binding for `%s`" key-string))))))

(use-package evil-god-state
  :after (evil god-mode)
  :general (:prefix my-prefix
		    "," #'evil-execute-in-god-state)
  :hook ((god-mode-enabled . (lambda () (setq exwm-input-line-mode-passthrough t)))
	 (god-mode-disabled . (lambda () (setq exwm-input-line-mode-passthrough nil)))))

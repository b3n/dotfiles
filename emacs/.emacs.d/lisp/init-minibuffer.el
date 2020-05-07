(use-package savehist
  :custom
  (history-length 9999)

  :config
  (savehist-mode 1))


(use-package rfn-eshadow
  :config
  (file-name-shadow-mode 1))


(use-package minibuffer
  :general
  (minibuffer-local-completion-map
   "S-<return>" #'minibuffer-complete-and-exit)
  ;; (completion-list-mode-map :keymaps 'override
  ;;  "d" (lambda ()
  ;;        (interactive)
  ;;        (message (cons "*Completions Dired*" (mapcar (lambda (x) (concat my-find-all-files x)) (split-string (buffer-substring (point) (point-max))))))))
  ;; (general-define-key :states 'insert "<tab>" #'completion-at-point)

  :custom
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(substring partial-completion flex))
  (enable-recursive-minibuffers t)

  :config
  (setq completion-in-region-function (lambda (start end collection &optional predicate)
  "Prompt for completion of region in the minibuffer if non-unique."
    (if (and (minibufferp) (not (string= (minibuffer-prompt) "Eval: ")))
        (completion--in-region start end collection predicate)
      (let* ((initial (buffer-substring-no-properties start end))
             (limit (car (completion-boundaries initial collection predicate "")))
             (all (completion-all-completions initial collection predicate (length initial)))
             (completion (cond
                          ((atom all) nil)
                          ((and (consp all) (atom (cdr all)))
                           (concat (substring initial 0 limit) (car all)))
                          (t (completing-read "Completion: " collection predicate t initial)))))
        (if (null completion)
            (progn (message "No completion") nil)
          (delete-region start end)
          (insert completion)
          t)))))

  (minibuffer-electric-default-mode 1))


(use-package icomplete
  :demand

  :general
  (icomplete-minibuffer-map
   "<right>" #'icomplete-forward-completions
   "<left>" #'icomplete-backward-completions
   "DEL" #'icomplete-fido-backward-updir
   "<return>" #'icomplete-fido-ret
   "M-<return>" #'icomplete-fido-exit)

  :custom
  (icomplete-prospects-height 1)
  (icomplete-separator "  ")
  (icomplete-show-matches-on-no-input t)
  (icomplete-tidy-shadowed-file-names t)

  :config
  (icomplete-mode))


(use-package restricto
  :after minibuffer
  :straight (:host github :repo "oantolin/restricto")

  :general
  (minibuffer-local-completion-map
   "SPC" #'restricto-narrow
   "S-SPC" #'restricto-widen)

  :config
  (restricto-mode))


(provide 'init-minibuffer)

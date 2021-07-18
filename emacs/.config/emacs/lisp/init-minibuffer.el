(use-package savehist
  :custom
  (history-length 99999)

  :config
  (savehist-mode 1))


(use-package rfn-eshadow
  :config
  (file-name-shadow-mode 1))


(use-package minibuffer
  :init
  (setq completion-category-defaults nil)

  (defun my-completion-in-region (start end collection &optional predicate)
    "Complete in-buffer text using a list of candidates.
Can be used as `completion-in-region-function'. For START, END,
COLLECTION, and PREDICATE, see `completion-in-region'."
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
          t))))

  :custom
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(substring partial-completion flex))
  (completion-in-region-function #'my-completion-in-region)

  :config
  (minibuffer-electric-default-mode 1))


(use-package orderless
  :straight t
  :custom (completion-styles '(substring orderless partial-completion flex)))


(use-package icomplete
  :demand t

  :bind (:map icomplete-minibuffer-map
   ("<left>"     . icomplete-backward-completions)
   ("<right>"    . icomplete-forward-completions)
   ("<return>"   . icomplete-fido-ret)
   ("C-k"        . icomplete-fido-kill)
   ("DEL"        . icomplete-fido-backward-updir)
   ("M-<return>" . icomplete-fido-exit))

  :custom
  (icomplete-prospects-height 1)
  (icomplete-separator (propertize ", " 'face 'shadow))
  (icomplete-show-matches-on-no-input t)

  :config
  (setq icomplete-tidy-shadowed-file-names t)
  (icomplete-mode))


(provide 'init-minibuffer)

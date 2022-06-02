;;; Bens-MacBook-Pro-15.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This extends my configuration for $DAYJOB.

;;; Code:

(require 'helpers)


;;; Miscellaneous (to be categorised)

(custom-set-faces
 '(default ((t (:family "JetBrains Mono NL" :height 150))))
 '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 155))))
 '(variable-pitch ((t (:family "Baskerville" :height 160)))))

(setq-default fill-column 100
              tab-width 2)

(setq default-directory "~/")

(setc sh-basic-offset 2
      js-indent-level 2)

(after typescript-mode
  (setc typescript-indent-level 2))


(after magit
  (defun github-open ()
    "Open Canva GitHub for the current file."
    (interactive)
    (let* ((root (expand-file-name (project-root (project-current t))))
           (repo (car (last (split-string root "/") 2)))
           (path (replace-regexp-in-string (regexp-quote root) "" buffer-file-name))
           (start (line-number-at-pos (region-beginning)))
           (end (line-number-at-pos (region-end))))
      (browse-url (format "https://github.com/Canva/%s/blob/master/%s#L%s-L%s" repo path start end))))
  
  ;; Monorepo makes git slow, so do a little less on magit refresh
  (setc magit-refresh-status-buffer nil)
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))

(after blacken
  (setc blacken-line-length 100))
(add-hook 'python-mode-hook #'blacken-mode)

(after terraform-mode)

(after bazel)

(after web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(after dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(after yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\(\\.j2\\)?\\'" . yaml-mode))

(add-to-list 'auto-mode-alist '("\\.xlf\\'" . xml-mode))

(after java-mode
  ;;TODO: Move dprint to its own package
  (defun my-dprint ()
    "Format current buffer with dprint."
    (interactive)
    (let ((dprint "~/work/canva/tools/dprint/dprint")
          (point (point))
          (window-start (window-start)))
      (call-process-region nil nil dprint t t nil "fmt" "--stdin" (buffer-name))
      (goto-char point)
      (set-window-start nil window-start)))

  (add-hook 'java-mode-hook (lambda ()
           (electric-indent-local-mode -1)
           (add-hook 'before-save-hook #'my-dprint nil 'local)
           (setq-local c-basic-offset 2
                       c-offsets-alist nil
                       indent-tabs-mode nil
                       evil-shift-width 2)))
  (after eglot-java)
  (eglot-java-init))

;; `project-find-file' is too slow on the monorepo
(after find-file-in-project
  (setc ffip-use-rust-fd t))
(bind global
  "C-x F" find-file-in-project
  "C-x f" find-file-in-project-by-selected)

(after restclient)

(provide 'Bens-MacBook-Pro-15)

;;; Bens-MacBook-Pro-15.el ends here

;;; work.el --- Ben's MacOS configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This extends my configuration for $DAYJOB.

;;; Code:

(setq-default fill-column 100
              tab-width 2)

(setq sh-basic-offset 2
      js-indent-level 2)

(my-use 'typescript-mode
  (setq typescript-indent-level 2))


(with-eval-after-load 'magit
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
  (setq magit-refresh-status-buffer nil)
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))

(my-use 'blacken
  (setq blacken-line-length 100))
(add-hook 'python-mode-hook #'blacken-mode)

(my-use 'terraform-mode)

(my-use 'bazel)

(my-use 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . 'web-mode))

(my-use 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . 'dockerfile-mode))

(my-use 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\(\\.j2\\)?\\'" . 'yaml-mode))

(add-to-list 'auto-mode-alist '("\\.xlf\\'" . 'xml-mode))

(with-eval-after-load 'java-mode
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
  (my-use 'eglot-java)
  (eglot-java-init))

;; `project-find-file' is too slow on the monorepo
(my-use 'find-file-in-project
  (setq ffip-use-rust-fd t))
(my-key global
  "C-x F" find-file-in-project
  "C-x f" find-file-in-project-by-selected)

(my-use 'restclient)

(provide 'work)

;;; work.el ends here

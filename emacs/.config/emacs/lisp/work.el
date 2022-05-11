;;; work.el -- Ben's MacOS configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This extends my configuration for $DAYJOB.

;;; Code:

(setq-default fill-column 100
              tab-width 2)

(setup cus-face
  (custom-set-faces
   '(default ((t (:family "Fira Code" :height 150))))
   '(fixed-pitch ((t (:family "JetBrains Mono" :height 145))))
   '(variable-pitch ((t (:family "Libre Baskerville" :height 200))))))


(setup js
  (:option js-indent-level 2))


(setup (:package typescript-mode)
  (:option typescript-indent-level 2))


(setup sh-script
  (:option sh-basic-offset 2))


(setup (:require magit)
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
  (:option magit-refresh-status-buffer nil)
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header))


(setup (:package vterm)
  (:option vterm-max-scrollback 100000
           vterm-buffer-name-string "vterm<%s>")
  (:global "C-c v" #'vterm)
  (:bind "C-<escape>"
         (lambda () (interactive) (vterm-send-key (kbd "C-[")))))


(setup (:package blacken)
  (:hook-into python-mode)
  (:option blacken-line-length 100))


(setup (:package terraform-mode))


(setup (:package bazel))


(setup (:package web-mode)
  (:file-match "\\.tsx\\'"))


(setup (:package dockerfile-mode)
  (:file-match "Dockerfile\\'"))


(setup (:package yaml-mode)
  (:file-match "\\.ya?ml\\(\\.j2\\)?\\'"))


(setup xml-mode
  (:file-match "\\.xlf\\'"))


(setup java-mode
  (defun dprint ()
    "Format current buffer with dprint."
    (interactive)
    (let ((dprint "~/work/canva/tools/dprint/dprint")
          (point (point))
          (window-start (window-start)))
      (call-process-region nil nil dprint t t nil "fmt" "--stdin" (buffer-name))
      (goto-char point)
      (set-window-start nil window-start)))
  (:hook (lambda ()
           (electric-indent-local-mode -1)
           (add-hook 'before-save-hook #'dprint nil 'local)
           (setq-local c-basic-offset 2
                       c-offsets-alist nil
                       indent-tabs-mode nil
                       evil-shift-width 2)))
  (:package eglot-java)
  (eglot-java-init))


;; `project-find-file' is too slow on the monorepo
(setup (:package find-file-in-project)
  (:global "C-x F" #'find-file-in-project
           "C-x f" #'find-file-in-project-by-selected)
  (:option ffip-use-rust-fd t))


(setup (:package restclient))


(provide 'work)

;;; work.el ends here

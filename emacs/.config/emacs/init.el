;;; init.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is my personal Emacs configuration, it's unlikely to be useful to
;; anyone else.  See also: `early-init.el'.

;;; Code:

(require 'my-helpers)


;;; Setup

(setq custom-file (make-temp-file "emacs-custom-"))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-archive-priorities '(("gnu" . 2) ("nongnu" . 1)))
(package-refresh-contents t)


;;; Basic settings

(setq initial-buffer-choice "~/todo.org")
(setq initial-scratch-message nil)

;; By default passwords were getting stored on disk unencrypted...
(setq auth-sources
        `(,(expand-file-name "authinfo.gpg" user-emacs-directory)
          ,(expand-file-name "authinfo" temporary-file-directory)
          "~/.netrc"))

(add-hook 'text-mode-hook #'turn-on-visual-line-mode)
(setq completion-show-help nil)
(setq async-shell-command-buffer 'rename-buffer)
(setq save-interprogram-paste-before-kill t)
(column-number-mode)

(save-place-mode 1)

(setq uniquify-buffer-name-style 'forward)

(setq tab-always-indent 'complete)

(setq auto-save-default t)
(setq auto-save-visited-interval 60)
(setq backup-by-copying t)
(setq backup-directory-alist
        `((,tramp-file-name-regexp . nil)
          (".*" . ,(expand-file-name "backups" user-emacs-directory))))
(setq confirm-kill-emacs 'yes-or-no-p)
(setq delete-old-versions t)
(setq enable-dir-local-variables nil)
(setq enable-local-eval nil)
(setq enable-local-variables nil)
(setq kept-new-versions 10)
(setq vc-make-backup-files t)
(setq version-control t)
(setq view-read-only t)
(auto-save-visited-mode 1)

(setq isearch-lazy-count t)

(setq narrow-to-defun-include-comments t)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;;; Minibuffer and completions

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

(defun my-icomplete-root ()
  "Go to the project root in `find-file', or the parent dir."
  (interactive)
  (if (and (eq (icomplete--category) 'file) (project-current))
      (progn (delete-minibuffer-contents)
             (insert (project-root (project-current))))
    (call-interactively #'icomplete-fido-backward-updir)))

(my-key icomplete-fido-mode
  "M-DEL" my-icomplete-root
  "M-<return>" icomplete-fido-exit
  "C-r" nil
  "C-s" nil)

(setq icomplete-prospects-height 1)

(fido-mode 1)

(defun my-completion-styles ()
"Override the default completion style.

This has to happen in a hook, because `fido-mode' also uses a hook to set the
flex style."
  (setq-local completion-styles '(substring flex basic)))
(add-hook 'minibuffer-setup-hook #'my-completion-styles 1)

(my-use 'completion-in-buffer)

(setq completion-category-overrides
        '((file (styles basic partial-completion flex))))
(setq completions-detailed t)

(minibuffer-electric-default-mode 1)

(my-use 'restricto
  (my-key minibuffer-local-completion
    "SPC" restricto-narrow
    "S-SPC" restricto-widen))
(restricto-mode)

(file-name-shadow-mode 1)

(setq history-delete-duplicates t)
(setq history-length 1000)
(savehist-mode 1)

(my-use 'minibuffer-repeat)
(add-hook 'minibuffer-setup-hook #'minibuffer-repeat-save)
(global-set-key (kbd "C-c m") #'minibuffer-repeat)



;;; Theme and display options

(my-use 'minibuffer-line
  (setq minibuffer-line-format '(:eval global-mode-string))
  (setq minibuffer-line-refresh-interval 1)
  (setq mode-line-misc-info nil))
(minibuffer-line-mode)

(load-theme 'modus-vivendi t)
(setq modus-themes-bold-constructs t)
(setq modus-themes-headings '((1 1.2) (t t)))
(setq modus-themes-mixed-fonts t)
(setq modus-themes-mode-line '(accented))
(setq modus-themes-org-blocks 'gray-background)
(setq modus-themes-slanted-constructs t)
(let ((daily (* 60 60 24)))
  ;; Set a light theme during work hours, otherwise dark.
  (run-at-time "09:00" daily #'modus-themes-load-operandi)
  (run-at-time "17:30" daily #'modus-themes-load-vivendi))

(custom-set-faces
 '(default ((t (:family "JetBrains Mono NL" :height 175))))
 '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 185))))
 '(variable-pitch ((t (:family "Baskerville" :height 195)))))

;; Helps to visualise wrapped and hidden lines
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq-default display-line-numbers-widen t)


;;; Text editing

(my-use 'vundo
  (setq vundo-glyph-alist vundo-unicode-symbols))
(global-set-key (kbd "C-x u") #'vundo)

(global-set-key [remap dabbrev-expand] #'hippie-expand)
(my-use 'yasnippet
  (my-use 'yasnippet-snippets)
  (define-key yas-minor-mode-map [tab] nil)
  (delete 'try-expand-list hippie-expand-try-functions-list)
  (add-to-list 'hippie-expand-try-functions-list #'yas-hippie-try-expand))
(yas-global-mode)

(my-use 'evil
  (setq evil-disable-insert-state-bindings t)
  (setq evil-echo-state nil)
  (setq evil-kill-on-visual-paste nil)
  (setq evil-mode-line-format 'after)
  (setq evil-symbol-word-search t)
  (setq evil-undo-system 'undo-redo)
  (setq evil-visual-region-expanded t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-minibuffer t)
  (setq evil-insert-state-modes (append evil-emacs-state-modes evil-insert-state-modes))
  (setq evil-emacs-state-modes '(exwm-mode vundo-mode))
  (my-key evil-insert-state
    "C-w" evil-window-map)
  (my-key evil-motion-state
    "RET" nil
    "<down-mouse-1>" nil
    "SPC" evil-execute-in-emacs-state
    "i" evil-insert ;; "Insert" is our "Emacs-state", so we want it here
    "Q" unbury-buffer)
  (my-key evil-normal-state
    "K" join-line
    "S" kmacro-start-macro-or-insert-counter
    "s" kmacro-end-or-call-macro
    "q" bury-buffer)
  (my-key evil-visual-state
    "v" evil-visual-line)
  (my-key evil-window
    "C-f" other-frame
    "f" other-frame
    "u" winner-undo
    "C-u" winner-undo
    "C-r" winner-redo))
(setq evil-want-integration nil)
(setq evil-want-keybinding nil)
(evil-mode)

;;(electric-pair-mode 1)


;;; Window and buffer management

(setq display-buffer-alist
        '(("\*Register Preview\*" (display-buffer-pop-up-window))
          ("." (display-buffer-reuse-window
                display-buffer-same-window
                display-buffer-pop-up-window))))

(my-key global "C-x C-b" ibuffer)

(winner-mode)

(my-use 'same-mode-buffer)
(my-key global
  [mode-line mouse-4] same-mode-buffer-previous
  "C-<tab>" same-mode-buffer-previous
  [mode-line mouse-5] same-mode-buffer-next
  "C-S-<tab>" same-mode-buffer-next)

(midnight-mode)


;;; File management

(with-eval-after-load 'dired
  (require 'dired-x)
  (my-use 'async)
  (add-hook 'dired-mode-hook #'dired-async-mode)
  (setq dired-listing-switches "-hal"
          dired-dwim-target t))
(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)



;;; Shell

;; (setup (:package exec-path-from-shell with-editor)
;;   (:option exec-path-from-shell-arguments nil)
;;   (:with-mode with-editor-export-editor
;;     (:hook-into eshell-mode shell-mode term-exec vterm-mode))
;;   (exec-path-from-shell-initialize))
(setenv "PAGER" "cat")

(my-key global "C-c e" eshell)
(setq eshell-hist-ignoredups t
      eshell-history-size 1000
      eshell-destroy-buffer-when-process-dies t)

(defun my-eshell-buffer-name ()
  "Include pwd in eshell prompt."
  (rename-buffer (concat "*eshell*<" (eshell/pwd) ">") t))
(add-hook 'eshell-prompt-load-hook #'my-eshell-buffer-name)
(add-hook 'eshell-directory-change-hook #'my-eshell-buffer-name)

(defun my-make-field ()
  "Make text in front of the point a field."
  (let ((inhibit-read-only t))
    (add-text-properties
     (line-beginning-position)
     (point)
     (list 'field t
           'rear-nonsticky t))))
(add-hook 'eshell-after-prompt-hook #'my-make-field)

(defun eshell/in-term (prog &rest args)
  "Run shell command PROG with args ARGS in term buffer."
  (apply #'make-term (format "in-term %s %s" prog args) prog nil args))

(my-use 'vterm
  (setq vterm-max-scrollback 100000
        vterm-buffer-name-string "vterm<%s>")
  (my-key vterm-mode
    "C-<escape>" (lambda () (interactive) (vterm-send-key (kbd "C-[")))))
(my-key global "C-c v" vterm)


;;; Programming

(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'prog-mode-hook #'flymake-mode)

(setq flymake-no-changes-timeout nil
      flymake-wrap-around nil)

(setq eldoc-echo-area-use-multiline-p nil)

(my-use 'csv-mode)

(my-use 'clojure-mode
  (my-use 'cider)
  (my-use 'flymake-kondor)
  (add-hook 'clojure-mode-hook #'flymake-kondor-setup))

(my-use 'eglot
  (my-key eglot-mode
    "C-c C-c" eglot-code-actions))
(dolist (hook '(python-mode-hook java-mode-hook clojure-mode-hook))
  (add-hook hook #'eglot-ensure))


;;; Writing and organisation

(add-hook 'text-mode-hook #'flyspell-mode)

(my-use 'olivetti)
(add-hook 'text-mode-hook #'olivetti-mode)

(my-use 'markdown-mode)
(add-to-list 'auto-mode-alist ("\\.md\\'" . 'markdown-mode))
(add-to-list 'auto-mode-alist ("README\\.md\\'" . 'gfm-mode))

(my-key global
  "C-c a" org-agenda
  "C-c c" org-capture)
(with-eval-after-load 'org
  (require 'org-habit)
  (setq org-agenda-custom-commands
        '((" " "My agenda"
           ((agenda "")
            (todo "IN-PROGRESS")
            (todo "NEXT")
            (todo "READING"))))
        org-agenda-files '("~/todo/" "~/notes/books.org")
        org-agenda-start-on-weekday nil
        org-agenda-window-setup 'current-window
        org-capture-templates
        `(("t" "Todo" entry (file+headline "~/todo/inbox.org" "Inbox") "* TODO %?")
          ("n" "Note" entry
           (file ,(lambda () (format-time-string "~/tmp/%Y-%m-%d.org")))
           "* %<%H:%M>\n%?\n"))
        org-ellipsis "  ⬎ "
        org-image-actual-width 300
        org-link-frame-setup '((file . find-file))
        org-log-done 'time
        org-return-follows-link t
        org-startup-folded 'content
        org-startup-indented t
        org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELED"))))


;;; Version control

(setq vc-follow-symlinks t)
(delete '(vc-mode vc-mode) mode-line-format)

(when (executable-find "git")
  (my-use 'magit
    (setq magit-diff-refine-hunk t
          magit-save-repository-buffers 'dontask
          magit-no-confirm '(stage-all-changes))
          (add-to-list 'display-buffer-alist
                       '("magit-diff: .*" (display-buffer-at-bottom display-buffer-pop-up-window))))
  (my-key global "C-c g" magit-file-dispatch))


;;; Miscellaneous (to be categorised)

(global-so-long-mode 1)

(my-use 'vlf)
(require 'vlf-setup)


(with-eval-after-load 'grep
  (setq grep-save-buffers 'dontask)
  (when (executable-find "rg")
    (grep-apply-setting
     'grep-find-command
     '("rg --no-heading --with-filename --max-columns=800 --glob='' '\\b\\b' " . 64))))
(my-key global "C-c s" grep-find)

(setq Man-notify-method 'pushy)

(setq calendar-week-start-day 1)
(setq calendar-holidays
      '((holiday-fixed 1 1 "New Year's Day")
        (holiday-fixed 2 14 "Valentine's Day")
        (holiday-fixed 3 17 "St. Patrick's Day")
        (holiday-fixed 4 1 "April Fools' Day")
        (holiday-easter-etc -47 "Pancake Day")
        (holiday-easter-etc -21 "Mother's Day")
        (holiday-easter-etc 0 "Easter Sunday")
        (holiday-float 6 0 3 "Father's Day")
        (holiday-fixed 10 31 "Halloween")
        (holiday-fixed 12 24 "Christmas Eve")
        (holiday-fixed 12 25 "Christmas Day")
        (holiday-fixed 12 26 "Boxing Day")
        (holiday-fixed 12 31 "New Year's Eve")))

(my-use 'password-gen
  (setq password-gen-length 32))
(my-key global "C-c p" password-gen)


;;; System specific initiation (yes, there's more...)

(require system-name nil t)


;;; init.el ends here

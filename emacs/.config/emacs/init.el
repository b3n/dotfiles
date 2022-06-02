;;; init.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is my personal Emacs configuration, it's unlikely to be useful to
;; anyone else.  See also: `early-init.el'.

;;; Code:

(require 'helpers)


;;; Basic settings

(setc custom-file (make-temp-file "emacs-custom-"))

(after package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (setc package-archive-priorities '(("gnu" . 2) ("nongnu" . 1)))
  (unless package-archive-contents
    (package-refresh-contents)))

(setc initial-buffer-choice "~/todo.org")
(setc initial-scratch-message nil)

;; By default passwords were getting stored on disk unencrypted...
(setc auth-sources
        `(,(expand-file-name "authinfo.gpg" user-emacs-directory)
          ,(expand-file-name "authinfo" temporary-file-directory)
          "~/.netrc"))

(add-hook 'text-mode-hook #'turn-on-visual-line-mode)
(setc completion-show-help nil)
(setc async-shell-command-buffer 'rename-buffer)
(setc save-interprogram-paste-before-kill t)
(column-number-mode)

(save-place-mode 1)

(setc uniquify-buffer-name-style 'forward)

(setc tab-always-indent 'complete)

(setc auto-save-default t)
(setc auto-save-visited-interval 60)
(setc backup-by-copying t)
(setc backup-directory-alist
        `((,tramp-file-name-regexp . nil)
          (".*" . ,(expand-file-name "backups" user-emacs-directory))))
(setc confirm-kill-emacs 'yes-or-no-p)
(setc delete-old-versions t)
(setc enable-dir-local-variables nil)
(setc enable-local-eval nil)
(setc enable-local-variables nil)
(setc kept-new-versions 10)
(setc vc-make-backup-files t)
(setc version-control t)
(setc view-read-only t)
(auto-save-visited-mode 1)

(setc isearch-lazy-count t)

(setc narrow-to-defun-include-comments t)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;;; Minibuffer and completions

(setc enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

(defun my-icomplete-root ()
  "Go to the project root in `find-file', or the parent dir."
  (interactive)
  (if (and (eq (icomplete--category) 'file) (project-current))
      (progn (delete-minibuffer-contents)
             (insert (project-root (project-current))))
    (call-interactively #'icomplete-fido-backward-updir)))

(after icomplete
  (bind icomplete-fido-mode
    "M-DEL" my-icomplete-root
    ;; "M-<return>" icomplete-fido-exit
    "C-r" nil
    "C-s" nil))

(setc icomplete-prospects-height 1)

(fido-mode 1)

(defun my-completion-styles ()
"Override the default completion style.

This has to happen in a hook, because `fido-mode' also uses a hook to set the
flex style."
  (setq-local completion-styles '(substring flex basic)))
(add-hook 'minibuffer-setup-hook #'my-completion-styles 1)

(after completion-in-buffer)

(setc completion-category-overrides
        '((file (styles basic partial-completion flex))))
(setc completions-detailed t)

(minibuffer-electric-default-mode 1)

(after restricto
  (bind minibuffer-local-completion
    "SPC" restricto-narrow
    "S-SPC" restricto-widen))
(restricto-mode)

(file-name-shadow-mode 1)

(setc history-delete-duplicates t)
(setc history-length 1000)
(savehist-mode 1)

(after minibuffer-repeat)
(add-hook 'minibuffer-setup-hook #'minibuffer-repeat-save)
(bind global "C-c m" minibuffer-repeat)



;;; Theme and display options

(after minibuffer-line
  (setc minibuffer-line-format '(:eval global-mode-string))
  (setc minibuffer-line-refresh-interval 1)
  (setc mode-line-misc-info nil))
(minibuffer-line-mode)

(after modus-themes
  (setc modus-themes-bold-constructs t)
  (setc modus-themes-headings '((1 1.2) (t t)))
  (setc modus-themes-mixed-fonts t)
  (setc modus-themes-mode-line '(accented))
  (setc modus-themes-org-blocks 'gray-background)
  (setc modus-themes-slanted-constructs t)
  (let ((daily (* 60 60 24)))
    ;; Set a light theme during work hours, otherwise dark.
    (run-at-time "09:00" daily #'modus-themes-load-operandi)
    (run-at-time "17:30" daily #'modus-themes-load-vivendi)))
(modus-themes-load-themes)

;; Helps to visualise wrapped and hidden lines
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq-default display-line-numbers-widen t)


;;; Text editing

(setc sentence-end-double-space nil)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(after vundo
  (setc vundo-glyph-alist vundo-unicode-symbols))
(bind global "C-x u" vundo)

(bind global [remap dabbrev-expand] hippie-expand)
(after yasnippet
  (after yasnippet-snippets)
  (bind yas-minor-mode [tab] nil)
  (delete 'try-expand-list hippie-expand-try-functions-list)
  (add-to-list 'hippie-expand-try-functions-list #'yas-hippie-try-expand))
(yas-global-mode)

(after evil
  (setc evil-disable-insert-state-bindings t)
  (setc evil-echo-state nil)
  (setc evil-default-state 'insert)
  (setc evil-motion-state-modes nil)
  (setc evil-emacs-state-modes nil)
  (setc evil-kill-on-visual-paste nil)
  (setc evil-mode-line-format 'after)
  (setc evil-symbol-word-search t)
  (setc evil-undo-system 'undo-redo)
  (setc evil-visual-region-expanded t)
  (setc evil-want-Y-yank-to-eol t)
  (setc evil-want-minibuffer t)
  (bind evil-insert-state
    "C-w" evil-window-map)
  (bind evil-motion-state
    "RET" nil
    "<down-mouse-1>" nil
    "SPC" evil-execute-in-emacs-state
    "i" evil-insert ;; "Insert" is our "Emacs-state", so we want it here
    "Q" unbury-buffer)
  (bind evil-normal-state
    "K" join-line
    "S" kmacro-start-macro-or-insert-counter
    "s" kmacro-end-or-call-macro
    "q" bury-buffer)
  (bind evil-visual-state
    "v" evil-visual-line)
  (bind evil-window
    "C-f" other-frame
    "f" other-frame
    "u" winner-undo
    "C-u" winner-undo
    "C-r" winner-redo))
(setq evil-want-integration nil)
(setq evil-want-keybinding nil)
(evil-mode)


;;; Window and buffer management

(setc display-buffer-alist
        '(("\*Register Preview\*" (display-buffer-pop-up-window))
          ("\*Async Shell Command\*" (display-buffer-no-window))
          ("." (display-buffer-reuse-window
                display-buffer-same-window
                display-buffer-pop-up-window))))

(bind global "C-x C-b" ibuffer)

(winner-mode)

(after same-mode-buffer)
(bind global
  [mode-line mouse-4] same-mode-buffer-previous
  "C-<tab>" same-mode-buffer-previous
  [mode-line mouse-5] same-mode-buffer-next
  "C-S-<tab>" same-mode-buffer-next)

(midnight-mode)


;;; File management

(after dired
  (require 'dired-x)
  (setc dired-listing-switches "-hal")
  (setc dired-dwim-target t)
  (when (executable-find "xdg-open")
    (setc dired-guess-shell-alist-user '(("." "xdg-open"))))
  (after async)
  (add-hook 'dired-mode-hook #'dired-async-mode)
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'hl-line-mode))



;;; Shell

(after with-editor)
(add-hook 'eshell-mode-hook #'with-editor-export-editor)
(add-hook 'vterm-mode-hook #'with-editor-export-editor)
(setenv "PAGER" "cat")

(bind global "C-c e" eshell)
(setc eshell-hist-ignoredups t
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
  "Run shell command PROG after args ARGS in term buffer."
  (apply #'make-term (format "in-term %s %s" prog args) prog nil args))

(after vterm
  (setc vterm-max-scrollback 100000
        vterm-buffer-name-string "vterm<%s>")
  (bind vterm-mode
    "C-<escape>" (lambda () (interactive) (vterm-send-bind (kbd "C-[")))))
(bind global "C-c v" vterm)


;;; Programming

(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'prog-mode-hook #'flymake-mode)

(after flymake
  (setc flymake-no-changes-timeout nil
        flymake-wrap-around nil))

(after eldoc
  (setc eldoc-echo-area-use-multiline-p nil))

(after csv-mode)

(after clojure-mode
  (after cider)
  (after flymake-kondor)
  (add-hook 'clojure-mode-hook #'flymake-kondor-setup))

(after eglot
  (bind eglot-mode
    "C-c C-c" eglot-code-actions))
(dolist (hook '(python-mode-hook java-mode-hook clojure-mode-hook))
  (add-hook hook #'eglot-ensure))

(after elisp-mode
  (add-to-list 'elisp-flymake-byte-compile-load-path
               (expand-file-name "lisp" user-emacs-directory)))


;;; Writing and organization

(add-hook 'text-mode-hook #'flyspell-mode)

(after olivetti)
(add-hook 'text-mode-hook #'olivetti-mode)

(after markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(after org
  (require 'org-habit)
  (setc org-agenda-custom-commands
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
(bind global
  "C-c a" org-agenda
  "C-c c" org-capture)


;;; Version control

(setc vc-follow-symlinks t)
(delete '(vc-mode vc-mode) mode-line-format)

(when (executable-find "git")
  (after magit
    (setc magit-diff-refine-hunk t
          magit-save-repository-buffers 'dontask
          magit-no-confirm '(stage-all-changes))
          (add-to-list 'display-buffer-alist
                       '("magit-diff: .*" (display-buffer-at-bottom display-buffer-pop-up-window))))
  (bind global "C-c g" magit-file-dispatch))


;;; Miscellaneous (to be categorised)

(global-so-long-mode 1)

(after vlf)
(require 'vlf-setup)

(after grep
  (setc grep-save-buffers 'dontask)
  (when (executable-find "rg")
    (grep-apply-setting
     'grep-find-command
     '("rg --no-heading --after-filename --max-columns=800 --glob='' '\\b\\b' " . 64))))
(bind global "C-c s" grep-find)

(setc Man-notify-method 'pushy)

(setc calendar-week-start-day 1)
(setc calendar-holidays
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

(after password-gen
  (setc password-gen-length 32))
(bind global "C-c p" password-gen)


;;; System specific initiation (yes, there's more...)

(require (intern system-name) nil t)


;;; init.el ends here

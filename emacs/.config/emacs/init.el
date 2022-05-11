;;; init.el -- Ben's configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is my personal Emacs configuration, it's unlikely to be useful to
;; anyone else.  See also: `early-init.el'.

;;; Code:


;;; Basic settings

(setup auth-source
  (:option auth-sources `(,(expand-file-name "authinfo.gpg" user-emacs-directory)
                          ,(expand-file-name "authinfo" temporary-file-directory)
                          "~/.netrc")))

(setup cus-edit
  (:option custom-file (make-temp-file "emacs-custom")))

(setup simple
  (:with-feature turn-on-visual-line (:hook-into text-mode))
  (:option completion-show-help nil
           async-shell-command-buffer 'rename-buffer
           save-interprogram-paste-before-kill t)
  (column-number-mode))

(setup flyspell
  (:hook-into text-mode)
  (:with-feature flyspell-prog (:hook-into prog-mode)))

(setup saveplace
  (save-place-mode 1))

(setup uniquify
  (:option uniquify-buffer-name-style 'forward))

(setup startup
  (:option initial-buffer-choice "~/todo.org"
           initial-scratch-message ""))

(setup indent
  (:option tab-always-indent 'complete))

(setup files
  (:option auto-save-default t
           auto-save-visited-interval 60
           backup-by-copying t
           backup-directory-alist `((,tramp-file-name-regexp . nil)
                                    (".*" . ,(expand-file-name "backups" user-emacs-directory)))
           confirm-kill-emacs 'yes-or-no-p
           delete-old-versions t
           enable-dir-local-variables nil
           enable-local-eval nil
           enable-local-variables nil
           kept-new-versions 10
           vc-make-backup-files t
           version-control t
           view-read-only t)
  (auto-save-visited-mode 1))

(setup isearch
  (:option isearch-lazy-count t))

(setup bookmark
  (:option bookmark-save-flag 1))


;;; Minibuffer and completions

(setup (:package minibuffer-line)
  (:option minibuffer-line-format '(:eval global-mode-string)
           minibuffer-line-refresh-interval 1)
  (setq mode-line-misc-info nil)
  (minibuffer-line-mode))

(setup mb-depth
  (:option enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1))

(setup icomplete
  (defun my-icomplete-root ()
    "Go to the project root in find-file, or the parent dir"
    (interactive)
    (if (and (eq (icomplete--category) 'file) (project-current))
        (progn (delete-minibuffer-contents)
               (insert (project-root (project-current))))
      (call-interactively #'icomplete-fido-backward-updir)))

  (:with-map icomplete-fido-mode-map
    (:bind "M-DEL" #'my-icomplete-root
           "M-<return>" #'icomplete-fido-exit)
    (:unbind "C-r" "C-s"))

  (:option icomplete-prospects-height 1)

  (fido-mode 1)

  ;; Override the default fido-mode flex completion style, as flex doesn't order by
  ;; history. This has to happen in a hook, because fido-mode also uses a hook to do
  ;; this.
  (defun my-completion-styles ()
    (setq-local completion-styles '(substring flex)))
  (add-hook 'minibuffer-setup-hook #'my-completion-styles 1))

(setup minibuffer
  (:also-load completion-in-buffer)
  (:option completion-category-overrides
            '((file (styles . (partial-completion flex basic))))
           completions-detailed t)

  (minibuffer-electric-default-mode 1))

(setup (:require restricto)
  (:with-map minibuffer-local-completion-map
    (:bind "SPC" restricto-narrow
           "S-SPC" restricto-widen))

  (restricto-mode))

(setup rfn-eshadow
  (file-name-shadow-mode 1))

(setup savehist
  (:option history-delete-duplicates t
           history-length 1000)
  (savehist-mode 1))

;;TODO: I would like a way to resume a minibuffer (with input) after it has been exited.


;;; Theme and display options

(setup cus-face
  (custom-set-faces
   '(default ((t (:family "JetBrains Mono NL" :height 145))))
   '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 150))))
   '(variable-pitch ((t (:family "Baskerville" :height 195))))))

(setup (:require modus-themes)
  (:option modus-themes-bold-constructs t
           modus-themes-headings '((1 1.2) (2 1.1) (t t))
           modus-themes-mixed-fonts t
           modus-themes-mode-line '(accented)
           modus-themes-org-blocks 'gray-background
           modus-themes-slanted-constructs t)

  (let ((daily (* 60 60 24)))
    ;; Set a light theme during work hours, otherwise dark.
    ;;TODO: Adjust back to normal working times.
    (run-at-time "16:00" daily #'modus-themes-load-operandi)
    (run-at-time "00:30" daily #'modus-themes-load-vivendi)))


;;; Text editing

(setup (:package vundo)
  (:global "C-x u" #'vundo)
  (:when-loaded
    (:option vundo-glyph-alist vundo-unicode-symbols)))

(setup (:package yasnippet yasnippet-snippets)
  (:with-mode yas-minor-mode
    (:unbind "TAB" [(tab)]))
  (:global [remap dabbrev-expand] #'hippie-expand)
  (:option (prepend hippie-expand-try-functions-list) #'yas-hippie-try-expand)
  (yas-global-mode 1))

(setup evil
  (defun my-evil-normal-or-motion-state ()
    (interactive)
    (if (eq evil-previous-state 'motion)
        (evil-motion-state)
      (evil-normal-state)))

  (:package evil)
  (:require evil)

  (:with-map evil-insert-state-map
    (:bind "C-w" #'evil-window-map
           "<escape>" #'my-evil-normal-or-motion-state))
  (:with-map evil-motion-state-map
    (:bind "RET" nil
           "<down-mouse-1>" nil
           "SPC" #'evil-execute-in-emacs-state
           "i" #'evil-insert
           "Q" #'unbury-buffer))
  (:with-map evil-normal-state-map
    (:bind "q" #'bury-buffer
           "g q" #'evil-record-macro))
  (:with-map evil-visual-state-map
    (:bind "v" #'evil-visual-line))
  (:with-map evil-window-map
    (:bind "C-f" #'other-frame
           "f" #'other-frame))

  (:option evil-disable-insert-state-bindings t
           evil-echo-state nil
           evil-kill-on-visual-paste nil
           evil-mode-line-format 'after
           evil-symbol-word-search t
           evil-undo-system 'undo-redo
           evil-visual-region-expanded t
           evil-want-Y-yank-to-eol t
           evil-want-integration nil
           evil-want-keybinding nil
           evil-want-minibuffer t
           evil-lookup-func (lambda () (or (eldoc t) (call-interactively #'man-follow))))

  (setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
  (setq evil-emacs-state-modes '(exwm-mode))

  (evil-mode 1))

(setup elec-pair
  (electric-pair-mode 1))


;;; Window and buffer management

(setup window
  (:option display-buffer-alist
           '(("\*Register Preview\*" (display-buffer-pop-up-window))
             ("." (display-buffer-reuse-window
                   display-buffer-same-window
                   display-buffer-pop-up-window)))))

(setup ibuffer
  (:global "C-x C-b" #'ibuffer))

(setup winner
  (:with-map evil-window-map
    (:bind "u" #'winner-undo
           "C-u" #'winner-undo
           "C-r" #'winner-redo))

  (winner-mode 1))

(setup (:require same-mode-buffer)
  (:global [mode-line mouse-4] #'same-mode-buffer-previous
           "C-<tab>" #'same-mode-buffer-previous
           [mode-line mouse-5] #'same-mode-buffer-next
           "C-S-<tab>" #'same-mode-buffer-next))

(setup midnight
  (midnight-mode))


;;; File management

(setup dired
  (:also-load dired-x)
  (:hook dired-hide-details-mode
         hl-line-mode)
  (:option dired-listing-switches "-hal"
           dired-dwim-target t))

(setup image-dired
  (:option image-dired-thumb-size 500))

(setup (:package async)
  (:with-hook dired-mode-hook (:hook dired-async-mode)))

(setup browse-url
  (defun my-browse-url-xdg-open (url &optional ignored)
    (browse-url-xdg-open (replace-regexp-in-string "%20" "\\\\ " url)))

  (:option browse-url-handlers '(("\\`file:" #'my-browse-url-xdg-open))))



;;; Shell

(setup (:package exec-path-from-shell with-editor)
  (:option exec-path-from-shell-arguments nil)
  (:with-mode with-editor-export-editor
    (:hook-into eshell-mode shell-mode term-exec vterm-mode))
  (exec-path-from-shell-initialize)
  (setenv "PAGER" "cat"))

(setup eshell
  (:global "C-c e" #'eshell)
  (:option eshell-hist-ignoredups t
           eshell-history-size 1000
           eshell-destroy-buffer-when-process-dies t)
  
  (defun eshell-buffer-name ()
    (rename-buffer (concat "*eshell*<" (eshell/pwd) ">") t))
  (add-hook 'eshell-prompt-load-hook #'eshell-buffer-name)
  (add-hook 'eshell-directory-change-hook #'eshell-buffer-name)

  (defun my-make-field ()
    "Make text in front of the point a field, useful for prompts."
    (let ((inhibit-read-only t))
      (add-text-properties
       (line-beginning-position)
       (point)
       (list 'field t
             'rear-nonsticky t))))
  (add-hook 'eshell-after-prompt-hook #'my-make-field)

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (apply #'make-term (format "in-term %s %s" prog args) prog nil args)))


;;; Programming

(setup flymake
  (:hook-into prog-mode)
  (:option flymake-no-changes-timeout nil
           flymake-wrap-around nil))

(setup eldoc
  (:option eldoc-echo-area-use-multiline-p nil))

(setup (:package eglot)
  ;;TODO: Create wrapper around eglot-ensure which checks the major mode exists in
  ;; `eglot-server-programs' before trying to start eglot
  (:with-mode eglot-ensure
    (:hook-into prog-mode))
  (:bind "C-c C-c" #'eglot-code-actions)
  (:option eglot-autoshutdown t))

(setup (:package json-mode))

(setup (:package csv-mode))

(setup (:package clojure-mode cider flymake-kondor)
  (:with-mode flymake-kondor-setup
    (:hook-into clojure-mode)))


;;; Writing and organisation

(setup (:package olivetti)
  (:hook-into text-mode))

(setup (:package markdown-mode)
  (:file-match "\\.md\\'")
  (:with-mode gfm-mode
    (:file-match "README\\.md\\'")))

(setup tex
  (:package auctex)
  (:option latex-run-command "pdflatex"
           TeX-auto-save t
           TeX-parse-self t
           TeX-save-query nil
           TeX-PDF-mode t
           TeX-view-program-selection '((output-pdf "PDF Tools"))
           TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
           TeX-source-correlate-start-server t)
  (setq doc-view-continuous t)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(setup (:require org org-habit ob-calc)
  (:global "C-c a" #'org-agenda
           "C-c c" #'org-capture)

  (:option org-agenda-custom-commands
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
           org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELED")))

  (:hook (lambda () (electric-indent-local-mode -1))
         variable-pitch-mode))


;;; Version control

(setup vc-hooks
  (:option vc-follow-symlinks t)
  (delete '(vc-mode vc-mode) mode-line-format))

(setup (:package magit)
  (:global "C-c g" #'magit-status)
  (:option magit-diff-refine-hunk t
           magit-save-repository-buffers 'dontask
           magit-no-confirm '(stage-all-changes)
           magit-refresh-status-buffer nil
           (prepend display-buffer-alist) '("magit-diff: .*"
                                            (display-buffer-at-bottom
                                             display-buffer-pop-up-window))))


;;; Miscellaneous (to be categorised)

(setup so-long
  (global-so-long-mode 1))

(setup (:package vlf)
  (:require vlf-setup))

(setup (:package restclient))

(setup (:require grep)
  (:global "C-c s" #'grep-find)
  (:option grep-save-buffers 'dontask)

  (:only-if (executable-find "rg"))
  (grep-apply-setting
   'grep-find-command
   '("rg --no-heading --with-filename --max-columns=800 --glob='' '' " . 62)))

(setup man
  (:option Man-notify-method 'pushy))

(setup calendar
  (:option calendar-week-start-day 1
           calendar-holidays
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
             (holiday-fixed 12 31 "New Year's Eve"))))

(setup (:require password-gen)
  (:global "C-c p" #'password-gen)
  (:option password-gen-length 32))


;;; System specific initiation

(setup work
  (:only-if (equal system-name "Bens-MacBook-Pro-15"))
  (:require work))

(setup home
  ;;TODO: Use system name
  (:only-if (eq system-type 'gnu/linux))
  (:require home))


;;; init.el ends here

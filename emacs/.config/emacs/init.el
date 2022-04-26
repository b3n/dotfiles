;;; init.el -- Ben's configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is part 2 of my personal configuration, it's unlikely to be useful to
;; anyone else.  See `early-init.el' for part 1.

;;; Code:


(setup (:package exec-path-from-shell)
  (:option exec-path-from-shell-arguments nil)
  (exec-path-from-shell-initialize))


(setup (:package minibuffer-line)
  (:option minibuffer-line-format '(:eval global-mode-string)
           minibuffer-line-refresh-interval 1)
  (setq mode-line-misc-info nil)
  (minibuffer-line-mode))


(setup window
  (:option display-buffer-alist
           '((".*" (display-buffer-reuse-window display-buffer-same-window)))))


(setup startup
  (:option initial-scratch-message ""))


(setup indent
  (:option tab-always-indent 'complete))


(setup mb-depth
  (setq enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1))


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
           kept-new-versions 99
           vc-make-backup-files t
           version-control t)
  (auto-save-visited-mode 1))


(setup auth-source
  (:option auth-sources '("/tmp/.authinfo" "~/.authinfo.gpg")))


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


(setup (:package find-file-in-project)
  (:global "C-x F" #'find-file-in-project
           "C-x f" #'find-file-in-project-by-selected)
  (:option ffip-use-rust-fd t))


(setup isearch
  (:option isearch-lazy-count t))


(setup ibuffer
  (:global "C-x C-b" #'ibuffer))


(setup flymake
  (:hook-into prog-mode)
  (:option flymake-no-changes-timeout nil
           flymake-wrap-around nil))


(setup man
  (:option Man-notify-method 'pushy))


(setup (:package yasnippet yasnippet-snippets)
  (:with-mode yas-minor-mode
    (:unbind "TAB" [(tab)]))
  (:global [remap dabbrev-expand] #'hippie-expand)
  (add-to-list 'hippie-expand-try-functions-list #'yas-hippie-try-expand)
  (yas-global-mode 1))


(setup bookmark
  (:option bookmark-save-flag 1))


(setup cus-face
  (custom-set-faces
   '(default ((t (:family "JetBrains Mono NL" :height 145))))
   '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 130))))
   '(variable-pitch ((t (:family "Libre Baskerville" :height 115))))))


(setup (:require modus-themes)
  (:option modus-themes-bold-constructs t
           modus-themes-headings '((1 1.7) (2 1.4) (3 1.2) (4 1.1) (t t))
           modus-themes-mixed-fonts t
           modus-themes-mode-line '(accented)
           modus-themes-org-blocks 'gray-background
           modus-themes-region '(bg-only no-extend)
           modus-themes-slanted-constructs t)

  (let ((daily (* 60 60 24)))
    ;; Set a light theme during work hours, otherwise dark.
    (run-at-time "16:00" daily #'modus-themes-load-operandi)
    (run-at-time "00:30" daily #'modus-themes-load-vivendi)))


(setup savehist
  (:option history-delete-duplicates t
           history-length 10000)
  (savehist-mode 1))


(setup rfn-eshadow
  (file-name-shadow-mode 1))


(setup minibuffer
  (:with-map minibuffer-local-completion-map
    (:bind "S-<return>" #'minibuffer-complete-and-exit))
  (:option completion-styles '(substring partial-completion flex)
           completions-detailed t
           read-buffer-completion-ignore-case t
           read-file-name-completion-ignore-case t)

  (setq completion-category-defaults nil)
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


(setup (:package orderless)
  (:option completion-styles '(orderless partial-completion flex)))


(setup icomplete
  (defun b3n-icomplete-root ()
    "Go to the project root in find-file, or the parent dir"
    (interactive)
    (if (and
         (eq (icomplete--category) 'file)
         (project-current))
        (progn (delete-minibuffer-contents)
               (insert (project-root (project-current))))
      (call-interactively 'icomplete-fido-backward-updir)))

  (:with-map icomplete-minibuffer-map
    (:bind "<left>" #'icomplete-backward-completions
           "<right>" #'icomplete-forward-completions
           "<down>" #'icomplete-forward-completions
           "<up>" #'icomplete-backward-completions
           "DEL" #'icomplete-fido-backward-updir
           "M-DEL" #'b3n-icomplete-root
           "<return>" #'icomplete-fido-ret
           "C-k" #'icomplete-fido-kill
           "DEL" #'icomplete-fido-backward-updir
           "M-<return>" #'icomplete-fido-exit)

    (:option icomplete-prospects-height 1
             icomplete-separator (propertize ", " 'face 'shadow)
             icomplete-show-matches-on-no-input t)

    (setq icomplete-tidy-shadowed-file-names t)
    (icomplete-mode)))


(setup (:require password-gen)
  (:global "C-c p" #'password-gen)
  (:option password-gen-length 32))


(setup evil
  (defun b3n-evil-normal-or-motion-state ()
    (interactive)
    (if (eq evil-previous-state 'motion)
        (evil-motion-state)
      (evil-normal-state)))

  (defun b3n-evil-lookup-func ()
    (or (call-interactively #'eldoc)
        (call-interactively #'woman-follow)))

  (setq evil-want-keybinding nil)
  (setq evil-want-integration nil)

  (:package evil)
  (:require evil)

  (:with-map evil-insert-state-map
    (:bind "C-w" #'evil-window-map
           "<escape>" #'b3n-evil-normal-or-motion-state))
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
           evil-want-minibuffer t
           evil-lookup-func #'b3n-evil-lookup-func)

  (setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
  (setq evil-emacs-state-modes nil)

  (evil-mode 1))


(setup (:package evil-surround)
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-surround-region)
  (global-evil-surround-mode 1))


(setup winner
  (:with-map evil-window-map
    (:bind "u" #'winner-undo
           "C-u" #'winner-undo
           "C-r" #'winner-redo))

  (winner-mode 1))


(setup (:package rg)
  (:global "C-c s" #'rg-menu)

  (:option rg-command-line-flags '("--max-columns=999")
           rg-default-alias-fallback "everything"))


(setup (:package with-editor))


(setup eshell
  (:global "C-c e" #'eshell)
  (:hook with-editor-export-editor)
  (:option eshell-hist-ignoredups t
           eshell-history-size 99999
           eshell-destroy-buffer-when-process-dies t
           eshell-scroll-to-bottom-on-output t)
  (setenv "PAGER" "cat")

  (defun eshell-buffer-name ()
    (rename-buffer (concat "*eshell*<" (eshell/pwd) ">") t))
  (add-hook 'eshell-prompt-load-hook #'eshell-buffer-name)
  (add-hook 'eshell-directory-change-hook #'eshell-buffer-name)

  (defun b3n-make-field ()
    "Make text in front of the point a field, useful for prompts."
    (let ((inhibit-read-only t))
      (add-text-properties
       (line-beginning-position) (point)
       (list 'field t
             'rear-nonsticky t))))
  (add-hook 'eshell-after-prompt-hook #'b3n-make-field)

  (defun eshell/in-term (prog &rest args)
    "Run shell command in term buffer."
    (apply #'make-term (format "in-term %s %s" prog args) prog nil args))


  ;; Output the value of $? in eshell as well as the time taken by the previous command before printing $PS1.
  (defvar-local eshell-current-command-start-time nil)
  (defvar-local eshell-last-command-prompt nil)

  (defun eshell-current-command-start ()
    (setq eshell-current-command-start-time (current-time)))

  (defun eshell-current-command-stop ()
    (when eshell-current-command-start-time
      (setq eshell-last-command-prompt
            (format "\n(%i)(%.4fs)\n"
                    eshell-last-command-status
                    (float-time (time-subtract (current-time) eshell-current-command-start-time))))
      (setq eshell-current-command-start-time nil))
    (when eshell-last-command-prompt
      (eshell-interactive-print eshell-last-command-prompt)))

  (defun eshell-current-command-time-track ()
    (add-hook 'eshell-pre-command-hook #'eshell-current-command-start nil t)
    (add-hook 'eshell-post-command-hook #'eshell-current-command-stop nil t))

  (add-hook 'eshell-mode-hook #'eshell-current-command-time-track))


(setup vc-hooks
  (:option vc-follow-symlinks t)
  (delete '(vc-mode vc-mode) mode-line-format))


(setup (:package magit)
  (:global "C-c g" #'magit-status)
  (:option magit-diff-refine-hunk t
           magit-save-repository-buffers 'dontask
           magit-no-confirm '(stage-all-changes)
           magit-refresh-status-buffer nil))


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
  (defun b3n-browse-url-xdg-open (url &optional ignored)
    (browse-url-xdg-open (replace-regexp-in-string "%20" "\\\\ " url)))

  (:option browse-url-handlers '(("\\`file:" #'b3n-browse-url-xdg-open))))

(setup exwm
  (defun b3n-same-mode-next-buffer ()
    "Select next buffer of the same type"
    (interactive)
    (let ((new-buffer (car (b3n--same-mode-buffer-list))))
      (when new-buffer
        (bury-buffer)
        (switch-to-buffer new-buffer))))


  (defun b3n-same-mode-previous-buffer ()
    "Select previous buffer of the same type"
    (interactive)
    (let ((new-buffer (car (last (b3n--same-mode-buffer-list)))))
      (when new-buffer (switch-to-buffer new-buffer))))

  (defun b3n--same-mode-buffer-list (&optional mode)
    "List buffers of mode `mode' that are not already visible"
    (let ((mode (or mode major-mode)))
      (seq-filter (lambda (buffer) 
                    (and (not (get-buffer-window buffer 'visible))
                         (eq (buffer-local-value 'major-mode buffer) mode)))
                  (buffer-list))))

  (global-set-key [mode-line mouse-4] #'b3n-same-mode-previous-buffer)
  (global-set-key [mode-line mouse-5] #'b3n-same-mode-next-buffer)
  
  (:only-if (eq window-system 'x))

  (setq focus-follows-mouse t)

  (defun b3n-exwm-set-buffer-name ()
    "Make a nicer title and file name for the buffer"

    (setq-local exwm-title
                (concat
                 exwm-class-name
                 "<"
                 (if (<= (length exwm-title) 160)
                     exwm-title
                   (concat (substring exwm-title 0 150) "…"))
                 ">"))

    (exwm-workspace-rename-buffer exwm-title))

  (defun b3n-gtk-launch ()
    "Launch an X application via `gtk-launch'."
    (interactive)
    (require 'xdg)
    (let* ((extention "\\.desktop$")
           (dirs (mapcar (lambda (dir) (expand-file-name "applications" dir))
                         (cons (xdg-data-home) (xdg-data-dirs))))
           (apps (cl-loop for dir in dirs
                          if (file-exists-p dir)
                          append (cl-loop for file in (directory-files dir nil extention)
                                          collect (replace-regexp-in-string extention "" file)))))
      (call-process "gtk-launch" nil 0 nil (completing-read "Launch: " apps))))

  (defun b3n-exwm-buffer-settings ()
    (setq-local left-fringe-width 0)
    (setq-local right-fringe-width 0))

  (:package exwm)
  (:require exwm-randr)

  (:hook b3n-exwm-buffer-settings)
  (:with-hook '(exwm-update-class exwm-update-title) (:hook b3n-exwm-set-buffer-name))

  (:option exwm-randr-workspace-monitor-plist '(0 "HDMI-2" 1 "DP-1")
           exwm-workspace-number 2
           exwm-workspace-show-all-buffers t
           exwm-layout-show-all-buffers t
           exwm-input-simulation-keys
           `(([?\s-x] .  [?\C-x])
             ([?\s-c] .  [?\C-c])
             ([?\s-w] .  [?\C-w])
             ([?\s-a] .  [?\C-a])
             ([?\s-f] .  [?\C-f])
             ([?\s-l] .  [?\C-l])
             ([?\s-n] .  [?\C-n])
             ([?\s-o] .  [?\C-o])
             ([?\C-y] .  [?\C-v])
             ([?\C-a] .  [?\C-a])
             ([?\s-/] .  [?\C-f]) ;; Chrome search
             ([?\s-b] .  ,(kbd "C-S-a")) ;; Chrome switch tab with search
             ([?\s-v] .  [?\C-v]))
           exwm-input-global-keys
           `(([?\s-r] . exwm-reset)
             ([?\s-o] . exwm-workspace-swap)
             ([?\s-\s] . b3n-gtk-launch)))

  (scroll-bar-mode 0)
  (horizontal-scroll-bar-mode 0)

  (push ?\C-w exwm-input-prefix-keys)
  (push 'exwm-mode evil-insert-state-modes)

  (exwm-randr-enable))


(setup time
  (:option display-time-format "%F %R\t")
  (display-time-mode t))


(setup midnight
  (midnight-mode))


(setup erc
  (:option erc-fill-function 'erc-fill-static
           erc-fill-static-center 14
           erc-fill-column (- (/ (frame-width) 2) 3)
           erc-hide-list '("JOIN" "PART" "QUIT")
           erc-auto-query 'bury
           erc-kill-server-buffer-on-quit t
           erc-kill-queries-on-quit t
           erc-kill-buffer-on-part t
           erc-disable-ctcp-replies t
           erc-prompt (lambda () (format "%s>" (buffer-name)))
           erc-user-mode "+iR"
           erc-server "irc.libera.chat"
           erc-port "6697")
  (erc-spelling-mode))


(setup so-long
  (global-so-long-mode 1))


(setup (:package vlf)
  (:require vlf-setup))


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

  (:hook (lambda () (electric-indent-local-mode -1))))


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


(setup eldoc
  (:option eldoc-echo-area-use-multiline-p nil))


(setup (:package eglot)
  (:with-mode eglot-ensure
    (:hook-into prog-mode))

  (:option eglot-autoshutdown t))


(setup (:package json-mode))


(setup (:package clojure-mode cider flymake-kondor)
  (:with-mode flymake-kondor-setup
    (:hook-into clojure-mode)))


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


(setup (:package csv-mode))


(setup (:package vundo)
  (:global "C-x u" #'vundo)
  (:when-loaded
    (:option vundo-glyph-alist vundo-unicode-symbols)))



(setup work
  (:only-if (eq system-type 'darwin))
  (:require work))

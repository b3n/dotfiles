;;; init.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is my personal Emacs configuration, it's unlikely to be useful to
;; anyone else.

;;; Code:

(require 'early-init)  ;; To make Flymake happy


;;; Basic settings

(after auto-revert t
  (setc auto-revert-avoid-polling t))

(after cus-edit t
  (setc custom-file (make-temp-file "emacs-custom-")))

(after package t
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (setc package-archive-priorities '(("gnu" . 9) ("nongnu" . 5) ("melpa" . 1))))

(after auth-source t
  ;; Use a `.gpg' file by default to keep authentication sources encrypted.
  (setc auth-sources
        `(,(expand-file-name "authinfo.gpg" user-emacs-directory)
          ,(expand-file-name "authinfo" temporary-file-directory)
          "~/.netrc")))

(after simple t
  (setc completion-show-help nil)

  (setc async-shell-command-buffer 'rename-buffer)
  (add-to-list 'display-buffer-alist
               '("\*Async Shell Command\*" (display-buffer-no-window)))

  (setc save-interprogram-paste-before-kill t)
  (column-number-mode))

(after saveplace t
  (save-place-mode 1))

(after uniquify t
  (setc uniquify-buffer-name-style 'forward))

(after indent t
  (setc tab-always-indent 'complete))

(after files t
  (setc auto-save-visited-interval 60)
  (auto-save-visited-mode 1)

  (setc backup-by-copying t)
  (setc backup-directory-alist
        `((,tramp-file-name-regexp . nil)
          ("." . ,(expand-file-name "backups" user-emacs-directory))))
  (setc delete-old-versions t)
  (setc kept-new-versions 10)
  (setc vc-make-backup-files t)
  (setc version-control t)

  (setc confirm-kill-emacs 'yes-or-no-p)
  (setc view-read-only t)

  ;; Security
  (setq enable-dir-local-variables nil)
  (setc enable-local-eval nil)
  (setc enable-local-variables nil))

(after window t
  (setc scroll-error-top-bottom 1))

(after isearch t
  (setc isearch-lazy-count t)
  (setc lazy-highlight-cleanup nil))

(after emacs t
  (setc narrow-to-defun-include-comments t)
  (put 'narrow-to-defun 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'narrow-to-region 'disabled nil))


;;; Minibuffer and completions

(after mb-depth (setc enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1))

(after icomplete fido-mode
  (with-eval-after-load 'project
    (defun my-icomplete-root ()
      "Go to the project root in `find-file', or the parent dir."
      (interactive)
      (if (and (eq (icomplete--category) 'file) (project-current))
          (progn (delete-minibuffer-contents)
                 (insert (project-root (project-current))))
        (call-interactively #'icomplete-fido-backward-updir)))

    (bind icomplete-fido-mode
      "M-DEL" my-icomplete-root))

  (define-key icomplete-fido-mode-map (kbd "C-r") nil)
  (define-key icomplete-fido-mode-map (kbd "C-s") nil)

  (setc icomplete-prospects-height 1))

(after minibuffer t
  (defun my-completion-styles ()
    "Override the default completion style.

This has to happen in a hook, because `fido-mode' also uses a hook to set the
flex style."
    (setq-local completion-styles '(substring flex basic)))
  (add-hook 'minibuffer-setup-hook #'my-completion-styles 1)

  (after completion-in-buffer require)

  (setc completion-category-overrides
        '((file (styles basic partial-completion flex))))
  (setc completions-detailed t))

(after minibuf-eldef (minibuffer-electric-default-mode 1))

(after restricto restricto-mode
  (bind minibuffer-local-completion
    "SPC" restricto-narrow
    "S-SPC" restricto-widen))

(after rfn-eshadow (file-name-shadow-mode 1))

(after savehist (savehist-mode 1))

(after minibuffer-repeat require
  (add-hook 'minibuffer-setup-hook #'minibuffer-repeat-save)
  (bind global "C-c m" minibuffer-repeat))



;;; Theme and display options

(after display-fill-column-indicator (hook prog-mode display-fill-column-indicator-mode))

(after modus-themes (modus-themes-load-themes)
  (setc modus-themes-bold-constructs t)
  (setc modus-themes-italic-constructs t)
  (setc modus-themes-headings '((1 1.3) (2 1.1) (t t)))
  (setc modus-themes-mixed-fonts t)
  (setc modus-themes-mode-line '(3d))
  (setc modus-themes-org-blocks 'gray-background)
  (let ((daily (* 60 60 24)))
    ;; Set a light theme during work hours, otherwise dark.
    (run-at-time "09:00" daily #'modus-themes-load-operandi)
    (run-at-time "17:30" daily #'modus-themes-load-vivendi)))


(after display-line-numbers (hook prog-mode display-line-numbers-mode)
  (setq-default display-line-numbers-widen t))


;;; Text editing

(after paragraphs t
  (setc sentence-end-double-space nil))

(after simple t
  (add-hook 'text-mode-hook #'turn-on-visual-line-mode)
  (add-hook 'before-save-hook #'delete-trailing-whitespace))

(after vundo (bind global "C-x u" vundo)
  (setc vundo-glyph-alist vundo-unicode-symbols))

(after yasnippet (yas-global-mode)
  (delete 'try-expand-list hippie-expand-try-functions-list)
  (after yasnippet-snippets require)
  (define-key yas-minor-mode-map [tab] nil)
  (bind global [remap dabbrev-expand] hippie-expand)
  (add-to-list 'hippie-expand-try-functions-list #'yas-hippie-try-expand))

(after evil (progn (setc evil-want-keybinding nil)
                   (evil-mode 1))
  (setc evil-disable-insert-state-bindings t)
  (setc evil-default-state 'insert)
  (setc evil-emacs-state-modes nil)
  (setc evil-motion-state-modes nil)
  (setc evil-normal-state-modes '(fundamental-mode text-mode prog-mode))

  (setc evil-echo-state nil)
  (setc evil-kill-on-visual-paste nil)
  (setc evil-mode-line-format 'after)
  (setc evil-symbol-word-search t)
  (setc evil-undo-system 'undo-redo)
  (setc evil-visual-region-expanded t)
  (setc evil-want-Y-yank-to-eol t)
  (setc evil-want-minibuffer t)

  (define-key evil-insert-state-map (kbd "C-w") 'evil-window-map)
  (bind evil-motion-state
    "RET" nil
    "<down-mouse-1>" nil
    "SPC" evil-execute-in-emacs-state
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
    "C-/" winner-undo
    "C-r" winner-redo)

  (after evil-surround global-evil-surround-mode))


;;; Window and buffer management

(after tab-bar t
  (setc tab-bar-show 1))

(setc display-buffer-alist
        '(("\*Register Preview\*" (display-buffer-pop-up-window))
          ("\*Async Shell Command\*" (display-buffer-no-window))
          ("." (display-buffer-reuse-window
                display-buffer-same-window
                display-buffer-pop-up-window))))

(setc help-window-select t)

(bind global [remap list-buffer] ibuffer)

(winner-mode)

(after same-mode-buffer (bind global
                          [mode-line mouse-4] same-mode-buffer-previous
                          "C-<tab>" same-mode-buffer-previous
                          [mode-line mouse-5] same-mode-buffer-next
                          "C-S-<tab>" same-mode-buffer-next))

(midnight-mode)


;;; File management

(after dired t
  (setc dired-recursive-deletes 'always)
  (setc dired-dwim-target t)
  (setc dired-listing-switches "-hal")
  (when (executable-find "xdg-open")
    (setc dired-guess-shell-alist-user '(("." "xdg-open"))))
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'hl-line-mode)

  (require 'dired-x)
  (setc dired-clean-confirm-killing-deleted-buffers nil)

  (after async (hook dired-mode dired-async-mode)))



;;; Shell

(after with-editor (progn
                     (hook eshell-mode with-editor-export-editor)
                     (hook vterm-mode with-editor-export-editor)))
;; (after exec-path-from-shell require)
;; (exec-path-from-shell-initialize)
(setenv "PAGER" "cat")

(after tramp t
  ;; https://www.reddit.com/r/GUIX/comments/uco6fg/comment/i6c407x
  (when (equal (system-name) "guix")
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)))

(after eshell (bind global "C-c e" eshell)
  (setc eshell-hist-ignoredups t)
  (setc eshell-history-size 1000)
  (setc eshell-destroy-buffer-when-process-dies t)

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
    (apply #'make-term (format "in-term %s %s" prog args) prog nil args)))

(after vterm require
  (bind global "C-c v" vterm)

  (setc vterm-max-scrollback 100000)
  (setc vterm-buffer-name-string "vterm<%s>")
  (bind vterm-mode
    "C-<escape>" (lambda () (interactive) (vterm-send-bind (kbd "C-[")))))


;;; Programming

(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'prog-mode-hook #'flymake-mode)

(after flymake require
  (setc flymake-no-changes-timeout nil)
  (setc flymake-wrap-around nil))

(after eldoc require
  (setc eldoc-echo-area-use-multiline-p nil))

(after csv-mode require)

(after clojure-mode nil
  (after cider require)
  (after flymake-kondor (hook clojure-mode flymake-kondor-setup)))

(after eglot nil
  ;; TODO: Improve `hook' macro to work with this use case
  (dolist (hook '(python-mode-hook java-mode-hook clojure-mode-hook))
               (add-hook hook #'eglot-ensure))
  (bind eglot-mode
    "C-c C-c" eglot-code-actions))

(after elisp-mode t
  (add-to-list 'elisp-flymake-byte-compile-load-path
               (expand-file-name "lisp" user-emacs-directory)))

(after js t
  (setc js-indent-level 2))


;;; Writing and organization

(hook text-mode flyspell-mode)

(after olivetti (hook text-mode olivetti-mode))

(after markdown-mode (progn
                       (auto-mode md markdown-mode)
                       (auto-mode "README\\.md" gfm-mode)))

(after org (bind global
             "C-c l" org-store-link
             "C-c a" org-agenda
             "C-c c" org-capture)
  (require 'org-habit)
  (setc org-agenda-custom-commands
        '((" " "My agenda"
           ((agenda "")
            (todo "IN-PROGRESS")
            (todo "NEXT")
            (todo "READING")))))
  (setc org-agenda-files '("~/todo/" "~/notes/books.org"))
  (setc org-agenda-start-on-weekday nil)
  (setc org-agenda-window-setup 'current-window)
  (setc org-capture-templates
        `(("t" "Todo" entry (file+headline "~/todo/inbox.org" "Inbox") "* TODO %?")
          ("b" "Books" entry (file+headline "~/notes/books.org" "Unsorted")
           "* TO-READ %x%?%^{author}p" :refile-targets ((nil . (:maxlevel . 2))))
          ("n" "Note" entry
           (file ,(lambda () (format-time-string "~/tmp/%Y-%m-%d.org")))
           "* %<%H:%M>\n%?\n")))
  (setc org-ellipsis "  ⬎ ")
  (setc org-image-actual-width 300)
  (setc org-link-frame-setup '((file . find-file)))
  (setc org-log-done 'time)
  (setc org-return-follows-link t)
  (setc org-startup-folded 'content)
  (setc org-startup-indented t)
  (setc org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "|" "DONE" "CANCELED"))))


;;; Version control

(setc vc-follow-symlinks t)
(delete '(vc-mode vc-mode) mode-line-format)

(when (executable-find "git")
  (after magit (bind global "C-c g" magit-file-dispatch)
    (setc magit-diff-refine-hunk t)
    (setc magit-save-repository-buffers 'dontask)
    (setc magit-no-confirm '(stage-all-changes))
    (setc magit-refresh-status-buffer nil)
    (add-to-list 'display-buffer-alist
                 '("magit-diff:" (display-buffer-at-bottom display-buffer-pop-up-window)))))


;;; Miscellaneous (to be categorized)

(global-so-long-mode 1)

(after vlf require
  (require 'vlf-setup)
  (add-to-list 'vlf-forbidden-modes-list 'pdf-view-mode))

(after grep (bind global "C-c s" grep-find)
  (setc grep-save-buffers 'dontask)
  (when (executable-find "rg")
    (grep-apply-setting
     'grep-find-command
     '("rg --no-heading --max-columns=800 --glob='' '\\b\\b' " . 57))))

(after find-file-in-project (bind global
                              "C-c F" find-file-in-project
                              "C-c f" find-file-in-project-by-selected)
  (when (executable-find "fd")
    (setc ffip-use-rust-fd t)))

(setc Man-notify-method 'pushy)

(setc calendar-week-start-day 1)

(after password-gen (bind global "C-c p" password-gen))

(after restclient)

(when (equal (system-name) "guix")
  (custom-set-faces
   '(default ((t (:family "JetBrains Mono NL" :height 185))))
   '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 190))))
   '(variable-pitch ((t (:family "Baskerville" :height 195))))))

(when (executable-find "pdflatex")
  (after tex nil
    (after auctex require)
    (setc latex-run-command "pdflatex")
    (setc TeX-auto-save t)
    (setc TeX-parse-self t)
    (setc TeX-save-query nil)
    (setc TeX-PDF-mode t)
    (setc TeX-view-program-selection '((output-pdf "PDF Tools")))
    (setc TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
    (setc TeX-source-correlate-start-server t))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(after erc t
  (setc erc-fill-function 'erc-fill-static)
  (setc erc-fill-static-center 14)
  (setc erc-fill-column (- (/ (frame-width) 2) 3))
  (setc erc-hide-list '("JOIN" "PART" "QUIT"))
  (setc erc-auto-query 'bury)
  (setc erc-kill-server-buffer-on-quit t)
  (setc erc-kill-queries-on-quit t)
  (setc erc-kill-buffer-on-part t)
  (setc erc-disable-ctcp-replies t)
  (setc erc-prompt (lambda () (format "%s>" (buffer-name))))
  (setc erc-user-mode "+iR")
  (setc erc-server "irc.libera.chat")
  (setc erc-port "6697"))

(when (equal (system-name) "guix")
  (after nov (auto-mode epub nov-mode)))

(when (equal (system-name) "guix")
  (after pdf-tools pdf-loader-install
    (setc doc-view-continuous t)))

(when (eq window-system 'x)
  (setc focus-follows-mouse t)
  (after exwm (require 'exwm-randr)

    (defun my--string-shorten (string)
      (if (<= (length string) 80)
          string
        (concat (substring string 0 70) "…")))

    (defun my-exwm-set-buffer-name ()
      "Rename the buffer to include the title."
      (exwm-workspace-rename-buffer
       (if exwm-title
           (thread-last exwm-title
                        (replace-regexp-in-string "\s+-[^-]*$" "")
                        my--string-shorten
                        (format "%s<%s>" exwm-class-name))
         exwm-class-name)))

    (add-hook 'exwm-update-class-hook #'my-exwm-set-buffer-name)
    (add-hook 'exwm-update-title-hook #'my-exwm-set-buffer-name)

    (defun my-gtk-launch ()
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

    (defun my-sleep ()
      "ZZzzzzz"
      (interactive)
      (message (shell-command-to-string "sleep 1 ; loginctl suspend ; slock")))

    (setc exwm-workspace-show-all-buffers t)
    (setc exwm-layout-show-all-buffers t)
    (setc exwm-input-simulation-keys
          '(([?\C-a] . [home])
            ([?\C-e] . [end])
            ([?\C-y] . [C-S-v])       ; Paste without formatting
            ;;([?\C-w] . [C-x])         ;;TODO: Correct conflict with evil-window.
            ([?\M-w] . [C-c])
            ([?\C-s] . [C-f return])
            ([?\C-v] . [next])
            ([?\M-v] . [prior])
            ([?\C-p] . [up])
            ([?\C-n] . [down])
            ([?\C-b] . [left])
            ([?\C-f] . [right])
            ([?\M-b] . [C-left])
            ([?\M-f] . [C-right])
            ([?\C-d] . [delete])
            ([?\C-k] . [S-end delete])
            ([?\C-x ?h] . [C-a])

            ;; MacOS style
            ([?\s-a] . [C-a])
            ([?\s-c] . [C-c])
            ([?\s-f] . [C-f])
            ([?\s-l] . [C-l])
            ([?\s-v] . [C-v])
            ([?\s-x] . [C-x])

            ;; Chrome
            ([?\s-b] . [C-S-a])       ; Search tabs
            ([?\s-k] . [C-w])         ; Close current tab
            ([?\C-x ?r ?m] . [C-d])   ; Bookmark page
            ([?\C-x ?\C-s] . [C-s])   ; Save page

            ([?\C-g] . [escape])))

    (setc exwm-input-global-keys
          `(([?\s-r] . exwm-reset)
            ([?\s-o] . exwm-workspace-swap)
            ([?\s-\s] . my-gtk-launch)
            ([?\s-S] . my-sleep)))


    (setc exwm-randr-workspace-monitor-plist '(0 "HDMI-2" 1 "DP-1"))

    (bind exwm-mode "C-q" exwm-input-send-next-key)

    (with-eval-after-load 'evil
      (add-to-list 'exwm-input-prefix-keys ?\C-w))

    (window-divider-mode 1)

    (after minibuffer-line minibuffer-line-mode
      (setc minibuffer-line-format '(:eval global-mode-string))
      (setc minibuffer-line-refresh-interval 1)
      (setq mode-line-misc-info
            (delete '(global-mode-string ("" global-mode-string)) mode-line-misc-info))
      (setc display-time-format "%F %R\t")
      (display-time-mode))

    (exwm-randr-enable)))


;;; Confidential settings

(require 'private (expand-file-name "private.el" user-emacs-directory) t)


;;; init.el ends here

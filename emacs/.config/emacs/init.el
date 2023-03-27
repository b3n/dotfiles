;;; init.el --- Ben's Emacs configuration   -*- lexical-binding: t -*-

;;; Commentary:

;; This is my personal Emacs configuration, it's unlikely to be useful to
;; anyone else.

;;; Code:

(require 'early-init)


;;; Basic settings

(cfg cus-edit t
  (setc custom-file (make-temp-file "emacs-custom-")))

(cfg package t
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (setc package-archive-priorities '(("gnu" . 2) ("nongnu" . 1) ("melpa" . -1))))

(cfg auth-source t
  ;; Use a `.gpg' file by default to keep authentication sources encrypted.
  (setc auth-sources
        `(,(expand-file-name "authinfo.gpg" user-emacs-directory)
          ,(expand-file-name "authinfo" temporary-file-directory)
          "~/.netrc")))

(cfg simple t
  (setc completion-show-help nil)

  (setc async-shell-command-buffer 'rename-buffer)
  (add-to-list 'display-buffer-alist
               '("\*Async Shell Command\*" (display-buffer-no-window)))

  (setc save-interprogram-paste-before-kill t)
  (column-number-mode))

(cfg saveplace (save-place-mode)
  (cfg saveplace-pdf-view require))

(cfg uniquify t
  (setc uniquify-buffer-name-style 'forward))

(cfg files t
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


;;; Search

(cfg isearch t
  (setc isearch-wrap-pause 'no-ding)
  (setc isearch-lazy-count t)
  (setc lazy-highlight-buffer t)
  (setc lazy-highlight-cleanup nil))

(cfg grep (bind global "C-c s" grep-find)
  (setc grep-save-buffers 'dontask)
  (when (executable-find "rg")
    (let* ((rg "rg --no-heading --max-columns=200 --max-columns-preview --smart-case --fixed-strings '' .")
					 (point (- (length rg) 2)))
      (grep-apply-setting
       'grep-find-command
       `(,rg . ,point))))
  (cfg wgrep require))

(cfg find-file-in-project (bind global
                              "C-c F" find-file-in-project
                              "C-c f" find-file-in-project-by-selected)
  (when (executable-find "fd")
    (setc ffip-use-rust-fd t)))


;;; Minibuffer and completions

(cfg mb-depth (minibuffer-depth-indicate-mode)
  (setc enable-recursive-minibuffers t))

(cfg icomplete (fido-mode)
  (cfg project t
    (defun my-icomplete-root ()
      "Go to the project root in `find-file', or the parent dir."
      (interactive)
      (if (and (eq (icomplete--category) 'file) (project-current))
          (progn (delete-minibuffer-contents)
                 (insert (project-root (project-current))))
        (call-interactively #'icomplete-fido-backward-updir)))

    (bind icomplete-fido-mode
      "M-DEL" my-icomplete-root))

  (bind icomplete-fido-mode "C-r" nil)
  (bind icomplete-fido-mode "C-S" nil)

  (setc icomplete-prospects-height 1))

(cfg minibuffer t
  (defun my-completion-styles ()
    "Override the default completion style.

This has to happen in a hook, because `fido-mode' also uses a hook to set the
flex style."
    (setq-local completion-styles '(substring flex basic)))
  (hook minibuffer-setup my-completion-styles 1)

  (setc completion-category-overrides
        '((file (styles basic partial-completion flex))))
  (setc completions-detailed t))

(cfg minibuf-eldef (minibuffer-electric-default-mode 1))

(cfg restricto restricto-mode
  (bind minibuffer-local-completion
    "SPC" restricto-narrow
    "S-SPC" restricto-widen))

(cfg rfn-eshadow (file-name-shadow-mode 1))

(cfg savehist (savehist-mode))

(cfg minibuffer-repeat require
  (hook minibuffer-setup minibuffer-repeat-save)
  (bind global "C-c m" minibuffer-repeat))

(cfg company (global-company-mode))


;;; Theme and display options

(when (equal (system-name) "framework")
  (custom-set-faces
   '(default ((t (:family "JetBrains Mono NL" :height 100))))
   '(fixed-pitch ((t (:family "JetBrains Mono NL" :height 105))))
   '(variable-pitch ((t (:family "DejaVu Serif" :height 120))))))

(cfg display-fill-column-indicator (hook prog-mode display-fill-column-indicator-mode))

(cfg modus-themes (load-theme 'modus-vivendi t)
  (setc modus-themes-bold-constructs t)
  (setc modus-themes-italic-constructs t)
  (setc modus-themes-headings '((1 1.3) (2 1.1) (t t)))
  (setc modus-themes-mixed-fonts t)
  (setc modus-themes-org-blocks 'gray-background))

(cfg display-line-numbers (hook prog-mode display-line-numbers-mode)
  (setq-default display-line-numbers-widen t))


;;; Text editing

(cfg paragraphs t
  (setc sentence-end-double-space nil))

(cfg simple t
  (hook text-mode turn-on-visual-line-mode)
  (hook before-save delete-trailing-whitespace))

(cfg vundo (bind global "C-x u" vundo)
  (setc vundo-glyph-alist vundo-unicode-symbols))

(cfg yasnippet (yas-global-mode)
  (delete 'try-expand-list hippie-expand-try-functions-list)
  (cfg yasnippet-snippets require)
  (bind yas-minor-mode "TAB" nil)
  (bind global [remap dabbrev-expand] hippie-expand)
  (add-to-list 'hippie-expand-try-functions-list #'yas-hippie-try-expand))

(cfg evil (progn (setc evil-want-keybinding nil)
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

  (bind evil-insert-state
    "C-w" evil-window-map
    "C-o" evil-execute-in-normal-state)
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
    "f" other-frame)

  (cfg evil-surround global-evil-surround-mode))


;;; Window and buffer management

(cfg window t
  (setc scroll-error-top-bottom 1))

(cfg tab-bar t
  (setc tab-bar-show 1))

;; (add-to-list 'display-buffer-alist
;;              '("\*Register Preview\*" (display-buffer-pop-up-window)))
;; (add-to-list 'display-buffer-alist
;;              '("." (display-buffer-reuse-window
;;                     display-buffer-same-window
;;                     display-buffer-pop-up-window)))

(cfg help t
  (setc help-window-select t))

(cfg ibuffer (bind global [remap list-buffers] ibuffer))

(cfg winner (winner-mode)
  (cfg evil evil-window-map
    (bind evil-window
      "u" winner-undo
      "C-u" winner-undo
      "C-/" winner-undo
      "C-r" winner-redo)))

(cfg same-mode-buffer (bind global
                          [mode-line mouse-4] same-mode-buffer-previous
                          "s-`" same-mode-buffer-previous
                          [mode-line mouse-5] same-mode-buffer-next
                          "s-~" same-mode-buffer-next))

(cfg midnight (midnight-mode))


;;; File management

(cfg dired t
  (setc dired-recursive-deletes 'always)
  (setc dired-dwim-target t)
  (setc dired-listing-switches "-hal")
  (when (executable-find "xdg-open")
    (setc dired-guess-shell-alist-user '(("." "xdg-open"))))

  (hook dired-mode dired-hide-details-mode)
  (hook dired-mode hl-line-mode)

  (bind dired-mode [mouse-2] dired-mouse-find-file)

  (cfg dired-x require
    (setc dired-clean-confirm-killing-deleted-buffers nil))

  (cfg async (hook dired-mode dired-async-mode)))



;;; Shell

(cfg tramp t
  ;; https://www.reddit.com/r/GUIX/comments/uco6fg/comment/i6c407x
  (when (equal (system-name) "framework")
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)))

(cfg eshell (bind global "C-c e" eshell)
  (setc eshell-destroy-buffer-when-process-dies t)
  (setc eshell-hist-ignoredups t)
  (setc eshell-history-size 9999)
  (setc eshell-scroll-to-bottom-on-input 'this)
  (setc eshell-input-filter
        (lambda (str)
          (not (or (string= "" str) (string-prefix-p " " str)))))
  (setc eshell-prompt-function (lambda () ";; "))
  (setc eshell-prompt-regexp ";; ")

  (setenv "PAGER" "cat")
  (cfg with-editor (hook eshell-mode with-editor-export-editor))

  (defun my-eshell-buffer-name ()
    "Eshell buffer name."
    (rename-buffer
     (concat "*eshell*<" (eshell/pwd) ">")
     t))
  (defun my-eshell-buffer-name-cmd ()
    "Append command name to eshell buffer name."
    (rename-buffer
     (concat (buffer-name) (concat "<" eshell-last-command-name ">"))
     t))
  (hook eshell-prompt-load my-eshell-buffer-name)
  (hook eshell-prepare-command my-eshell-buffer-name-cmd)
  (hook eshell-post-command my-eshell-buffer-name)

  (cfg eat (hook eshell-load eat-eshell-mode)
    (setc eshell-visual-commands nil)
    (setenv "TERM" "xterm-256color")
    (setc eat-term-scrollback-size 100000)))


;;; Programming

(cfg flyspell (hook prog-mode flyspell-prog-mode))

(cfg flymake (hook prog-mode flymake-mode)
  (setc flymake-no-changes-timeout nil)
  (setc flymake-wrap-around nil))

(cfg eldoc t
  (setc eldoc-echo-area-use-multiline-p nil))

(cfg csv-mode require)

(cfg clojure-mode nil
  (cfg cider require)
  (cfg flymake-kondor (hook clojure-mode flymake-kondor-setup)))

(cfg eglot commandp
  ;; TODO: Improve `hook' macro to work with this use case
  (dolist (hook '(python-mode-hook java-mode-hook clojure-mode-hook javascript-mode))
               (add-hook hook #'eglot-ensure))
  (bind eglot-mode
    "C-c C-c" eglot-code-actions))

(cfg elisp-mode t
  (add-to-list 'elisp-flymake-byte-compile-load-path
               (expand-file-name "lisp" user-emacs-directory)))

(cfg js t
  (setc js-indent-level 2))


;;; Writing and organization

(cfg flyspell (hook text-mode flyspell-mode))

(cfg olivetti (hook text-mode olivetti-mode))

(cfg markdown-mode (progn
                       (auto-mode md markdown-mode)
                       (auto-mode mdx markdown-mode)
                       (auto-mode "README\\.md" gfm-mode)))

(cfg org (bind global
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
  (cfg magit (bind global "C-c g" magit-file-dispatch)
    (setc git-commit-fill-column 72)
    (setc magit-diff-refine-hunk t)
    (setc magit-save-repository-buffers 'dontask)
    (setc magit-no-confirm '(stage-all-changes))
    (setc magit-refresh-status-buffer nil)
    (add-to-list 'display-buffer-alist
                 '("magit-diff:" (display-buffer-at-bottom display-buffer-pop-up-window)))))


;;; Miscellaneous (to be categorized)

(global-so-long-mode 1)

(cfg vlf (require 'vlf-setup)
  (setc large-file-warning-threshold nil)
  (add-to-list 'vlf-forbidden-modes-list 'pdf-view-mode))

(setc Man-notify-method 'pushy)

(setc calendar-week-start-day 1)

(cfg password-gen (bind global "C-c p" password-gen))

(cfg restclient)

(when (executable-find "pdflatex")
  (cfg tex nil
    (cfg auctex require)
    (setc latex-run-command "pdflatex")
    (setc TeX-auto-save t)
    (setc TeX-parse-self t)
    (setc TeX-save-query nil)
    (setc TeX-PDF-mode t)
    (setc TeX-view-program-selection '((output-pdf "PDF Tools")))
    (setc TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
    (setc TeX-source-correlate-start-server t))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(cfg erc t
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

(when (equal (system-name) "framework")
  (cfg nov (auto-mode epub nov-mode)))

(when (equal (system-name) "framework")
  (cfg pdf-tools (pdf-tools-install)
    (hook pdf-view-mode (lambda () (setq-local evil-insert-state-cursor '(nil))))
    (setc pdf-view-use-scaling t)
    (setq-default pdf-view-display-size 'fit-page)
    (setc doc-view-continuous t)))

(when (eq window-system 'x)
  (setc focus-follows-mouse t)
  (cfg exwm (require 'exwm-randr)
    (menu-bar-mode -1)

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

    (hook exwm-update-class my-exwm-set-buffer-name)
    (hook exwm-update-title my-exwm-set-buffer-name)



    (defun my-sleep ()
      "Zzz"
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
            ([?\s-S] . my-sleep)))


    (bind exwm-mode "C-q" exwm-input-send-next-key)

    (with-eval-after-load 'evil
      (add-to-list 'exwm-input-prefix-keys ?\C-w))

    (cfg minibuffer-line minibuffer-line-mode
      (setc minibuffer-line-format '(:eval global-mode-string))
      (setc minibuffer-line-refresh-interval 1)
      (setq mode-line-misc-info
            (delete '(global-mode-string ("" global-mode-string)) mode-line-misc-info))
      (setc display-time-format "%F %R\t")

      (when (equal (system-name) "framework")
        (display-time-mode)
        (display-battery-mode)))

    (setc exwm-randr-workspace-monitor-plist '(0 "DP-1" 1 "HDMI-2"))

    (defun my-xrandr ()
      (start-process-shell-command
       "xrandr" nil
       "xrandr --output DP-1 --mode 1920x1080 --output HDMI-2 --right-of DP-1 --mode 1920x1080"))
    (hook exwm-randr-screen-change my-xrandr)
    ;;(hook exwm-randr-refresh my-xrandr)

    (exwm-randr-enable)))


;;; Confidential settings

(require 'private (expand-file-name "private.el" user-emacs-directory) t)


;;; init.el ends here

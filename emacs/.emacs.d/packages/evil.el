(use-package evil
  :custom
  (evil-ex-complete-emacs-commands nil)
  (evil-search-module 'evil-search)
  (evil-shift-round nil)
  (evil-split-window-below t)
  (evil-symbol-word-search t)
  (evil-vsplit-window-right t)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol t)
  (evil-want-integration nil)  ; Using evil-collection instead.

  :config
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  (general-define-key :keymaps 'evil-window-map
                      "u" #'winner-undo
                      "C-r" #'winner-redo)
  (evil-mode))


(use-package evil-surround
  :after (evil)
  :config
  (global-evil-surround-mode 1))


(use-package evil-numbers
  :after (evil)
  :general (:states 'normal
		    "g+" #'evil-numbers/inc-at-pt
		    "g-" #'evil-numbers/dec-at-pt))


(use-package evil-visualstar
  :after (evil)

  :config
  (setq evil-visualstar/persistent t)
  (global-evil-visualstar-mode))


(use-package evil-exchange
  :after (evil)

  :config
  (evil-exchange-install))


(use-package evil-anzu
  :after (evil)
  :custom
  (anzu-cons-mode-line-p nil))  ; This is handled by Spaceline


(use-package evil-collection
  :after (evil)
  :config (evil-collection-init))


(use-package evil-org
  :after (evil org)
  :diminish evil-org-mode

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit
  :after (evil magit))

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

  :init
  (winner-mode 1)
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)

  :config
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  (define-key key-translation-map (kbd "SPC w") (kbd "C-w"))
  (general-define-key :keymaps 'evil-window-map
                      "u" #'winner-undo
                      "C-r" #'winner-redo)
  (my-leader-def "q c" (general-simulate-key ('evil-ex "%s///gn <S-left> <left> <left>")))
  (evil-mode))


(use-package evil-surround
  :after (evil)

  :config
  (global-evil-surround-mode 1))


(use-package evil-numbers
  :after (evil)
  :general (:states 'normal
                    "C-a" #'evil-numbers/inc-at-pt
                    "C-S-a" #'evil-numbers/dec-at-pt))


(use-package evil-visualstar
  :after (evil)

  :config
  (setq evil-visualstar/persistent t)
  (global-evil-visualstar-mode))


(use-package evil-exchange
  :after (evil)

  :config
  (evil-exchange-install))


(use-package evil-collection
  :after (evil)

  :init
  (setq evil-want-keybinding nil)

  :config
  (evil-collection-init))


(use-package evil-org
  :after (evil org)
  :diminish evil-org-mode

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit
  :after (evil magit))

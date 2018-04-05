(use-package evil
  :demand t
  :bind-keymap ("<f5> w" . evil-window-map)
  
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-integration nil)

  :config
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))

  (general-define-key :keymaps 'evil-window-map
		      "u" #'winner-undo
		      "C-r" #'winner-redo)
  (winner-mode 1)

  (evil-mode))


(use-package evil-surround
  :after (evil)
  :config
  (global-evil-surround-mode 1))


(use-package evil-numbers
  :after (evil)
  :general (:prefix my-prefix
		    "+" #'evil-numbers/inc-at-pt
		    "-" #'evil-numbers/dec-at-pt))


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
  :config (evil-collection-init))


(use-package evil-org
  :after (evil org)
  :diminish evil-org-mode

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit
  :after (evil magit))

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
  (evil-mode))


(use-package evil-surround
  :after (evil)
  :config
  (global-evil-surround-mode 1))


(use-package evil-collection
  :after (evil)
  :config (evil-collection-init))


(use-package evil-visualstar
  :after (evil)

  :config
  (setq evil-visualstar/persistent t)
  (global-evil-visualstar-mode))


(use-package evil-org
  :after (evil org)
  :diminish evil-org-mode

  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme))))


(use-package evil-magit
  :after (evil magit))

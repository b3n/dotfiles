(use-package ace-window
  :custom
  (aw-keys '(?\s-m ?\s-, ?\s-. ?\s-n ?\s-e ?\s-i ?\s-l ?\s-u ?\s-y))

  :config
  (add-to-list 'avy-key-to-char-alist '(?\s-m . ?m))
  (add-to-list 'avy-key-to-char-alist '(?\s-, . ?,))
  (add-to-list 'avy-key-to-char-alist '(?\s-. . ?.))
  (add-to-list 'avy-key-to-char-alist '(?\s-n . ?n))
  (add-to-list 'avy-key-to-char-alist '(?\s-e . ?e))
  (add-to-list 'avy-key-to-char-alist '(?\s-i . ?i))
  (add-to-list 'avy-key-to-char-alist '(?\s-l . ?l))
  (add-to-list 'avy-key-to-char-alist '(?\s-u . ?u))
  (add-to-list 'avy-key-to-char-alist '(?\s-y . ?y)))

(provide 'init-ace-window)

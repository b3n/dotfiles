(use-package yasnippet
  :straight t
  :hook ((text-mode . yas-minor-mode)
         (prog-mode . yas-minor-mode)
         (eshell-mode . yas-minor-mode)))


(use-package yasnippet-snippets
  :straight t)


(provide 'init-yasnippet)

(use-package default-text-scale
  :custom
  (default-text-scale-amount 25)

  :bind (("C-c z +" . default-text-scale-increase)
         ("C-c z -" . default-text-scale-decrease)
         ("C-c z 0" . default-text-scale-reset)
         ("C-c z b" . text-scale-adjust)))


(provide 'init-default-text-scale)

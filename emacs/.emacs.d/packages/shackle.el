(use-package shackle
  :config
  (setq shackle-default-rule '(:same t :inhibit-window-quit t))
  (setq shackle-rules
        ;; CONDITION(:regexp)            :select     :inhibit-window-quit   :size+:align|:other     :same|:popup
        '((compilation-mode              :select nil                                               )
          ("*undo-tree*"                                                    :size 0.25 :align right)
          ("*eshell*"                    :select t                          :other t               )
          ("*Shell Command Output*"      :select nil                                               )
          ("\\*Async Shell.*\\*" :regexp t :ignore t                                                 )
          (occur-mode                    :select nil                                   :align t    )
          ("*Help*"                      :select t   :inhibit-window-quit t :other t               )
          ("*Completions*"                                                  :size 0.3  :align t    )
          ("*Messages*"                  :select nil :inhibit-window-quit t :other t               )
          ("\\*[Wo]*Man.*\\*"    :regexp t :select t   :inhibit-window-quit t :other t               )
          ("\\*poporg.*\\*"      :regexp t :select t                          :other t               )
          ("\\`\\*helm.*?\\*\\'"   :regexp t                                    :size 0.3  :align t    )
          ("*Calendar*"                  :select t                          :size 0.3  :align below)
          ("*info*"                      :select t   :inhibit-window-quit t                         :same t)
          (magit-status-mode             :select t   :inhibit-window-quit t                         :same t)
          (magit-log-mode                :select t   :inhibit-window-quit t                         :same t)
          ))
  (shackle-mode))

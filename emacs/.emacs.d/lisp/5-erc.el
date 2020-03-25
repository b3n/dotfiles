(setq erc-lurker-hide-list '("JOIN" "PART" "QUIT")
      erc-lurker-threshold-time 3600)
(setq erc-join-buffer 'bury)
(setq erc-nick "Ben`")
(setq erc-format-query-as-channel-p t
      erc-track-priority-faces-only 'all
      erc-track-faces-priority-list '(erc-error-face
				      erc-current-nick-face
				      erc-keyword-face
				      erc-nick-msg-face
				      erc-direct-msg-face
				      erc-dangerous-host-face
				      erc-notice-face
				      erc-prompt-face))

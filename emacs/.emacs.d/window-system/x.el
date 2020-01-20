(my-leader-def
  "C-z" '((lambda () (interactive) (shell-command "doas zzz")) :which-key "Sleep")
  "C-x" '((lambda () (interactive) (shell-command "xrandr --output HDMI-2 --auto")) :which-key "Screen on"))

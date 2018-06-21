(use-package org
  :ensure org-plus-contrib
  :general (my-leader-def
             "o" '(:ignore t :which-key "Org")
             "o a" #'org-agenda
             "o c" #'org-capture)

  :custom
  (org-startup-indented t) 

  :config
  (add-hook 'org-mode-hook '(lambda () (visual-line-mode 1)))
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/gtd/gtd.org" "Inbox")
                                 "* %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/gtd/gtd.org" "Tickler")
                                 "* %i%? \n %^t")))
  (setq org-agenda-hide-tags-regexp "projects")
  (setq org-agenda-prefix-format '((agenda . "%?-12t% s")
                                   (timeline . "  % s")
                                   (todo . "%i %-12:c")
                                   (tags . "%-40>(car (last (org-get-outline-path)))")
                                   (search . "%i %-12:c")))

  (setq org-agenda-custom-commands
        '(("g" "Getting things done" tags-todo "projects"
           ((org-agenda-files '("~/gtd/gtd.org"))
            (org-agenda-overriding-header "Projects")
            (org-agenda-skip-function 'my-org-agenda-skip-all-siblings-but-first)
            (org-agenda-cmp-user-defined 'my-org-todo-state-sort)
            (org-agenda-sorting-strategy '(priority-down user-defined-up))))))

  (defun my-org-todo-state-sort (a b)
    "Order by IN-PROGRESS first, then TODO."
    (let* ((state-a (or (get-text-property 1 'todo-state a) ""))
           (state-b (or (get-text-property 1 'todo-state b) "")))
      (or
       (if (string= state-b "IN-PROGRESS") 1)
       (if (string= state-a "IN-PROGRESS") -1)
       (if (string= state-b "TODO") 1)
       (if (string= state-a "TODO") -1))))

  (defun my-org-agenda-skip-all-siblings-but-first ()
    "Skip all but the first non-done entry."
    (let (should-skip-entry)
      (unless (org-current-is-todo)
        (setq should-skip-entry t))
      (save-excursion
        (while (and (not should-skip-entry) (org-goto-sibling t))
          (when (org-current-is-todo)
            (setq should-skip-entry t))))
      (when should-skip-entry
        (or (outline-next-heading)
            (goto-char (point-max))))))

  (defun org-current-is-todo ()
    (or (string= "TODO" (org-get-todo-state))
        (string= "IN-PROGRESS" (org-get-todo-state))
        (string= "BLOCKED" (org-get-todo-state))))

  (setq org-agenda-files '("~/gtd/gtd.org" "~/gtd/contacts.org"))

  (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "BLOCKED" "|" "DONE" "CANCELLED")
                            (sequence "TO-READ" "CURRENTLY-READING" "|" "READ"))))

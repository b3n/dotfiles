(use-package org-static-blog
  :straight t

  :init
  (defun my-read-file (filePath)
    "Return FILEPATH's file content."
    (with-temp-buffer
      (insert-file-contents filePath)
      (buffer-string)))

  :custom
  (org-export-with-section-numbers nil)
  (org-export-with-toc nil)
  (org-static-blog-drafts-directory "~/projects/blog/drafts/")
  (org-static-blog-enable-tags t)
  (org-static-blog-page-header (my-read-file "~/projects/blog/templates/page-header.html"))
  (org-static-blog-page-postamble (my-read-file "~/projects/blog/templates/page-postamble.html"))
  (org-static-blog-page-preamble (my-read-file "~/projects/blog/templates/page-preamble.html"))
  (org-static-blog-posts-directory "~/projects/blog/posts/")
  (org-static-blog-publish-directory "~/projects/blog/")
  (org-static-blog-publish-title "Benedict J. Bentham's web log")
  (org-static-blog-publish-url "/")
  (org-static-blog-use-preview t)

  :config
  (defun org-static-blog-post-preamble (post-filename)
    (concat
     "<h1 class=\"post-title\">"
     "<a href=\"" (org-static-blog-get-post-url post-filename) "\">"
     (org-static-blog-get-title post-filename)
     "</a>"
     "<span class=\"date\">"
     ", "
     (format-time-string (org-static-blog-gettext 'date-format)
                         (org-static-blog-get-date post-filename))
     "</span>"
     "</h1>")))

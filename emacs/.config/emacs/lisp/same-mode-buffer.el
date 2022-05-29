;;; same-mode-buffer.el --- Switch to buffer with same mode   -*- lexical-binding: t -*-

;; Version: 0.1

;;; Commentary:

;; Defines two functions, `same-mode-buffer-next' and `same-mode-buffer-previous' which
;; behave like `next-buffer' and `previous-buffer' except skip over any buffers which
;; do not have the same major-mode as the current buffer.

;;; Code:


;;;###autoload
(defun same-mode-buffer-next ()
  "Select next buffer of the same mode."
  (interactive)
  (let ((switch-to-prev-buffer-skip #'same-mode-buffer--skip))
    (next-buffer)))

;;;###autoload
(defun same-mode-buffer-previous ()
  "Select previous buffer of the same mode."
  (interactive)
  (let ((switch-to-prev-buffer-skip #'same-mode-buffer--skip))
    (previous-buffer)))

(defun same-mode-buffer--skip (window buffer burry-or-kill)
  "Returns non-nil if buffer should be skipped."
  (or (get-buffer-window buffer 'visible)
      (not (eq (buffer-local-value 'major-mode buffer) major-mode))))


(provide 'same-mode-buffer)


;;; same-mode-buffer.el ends here

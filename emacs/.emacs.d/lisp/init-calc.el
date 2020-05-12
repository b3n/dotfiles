(use-package calc
  :bind ("C-c c" . calc-dispatch))


(use-package calc-units
  :config
  ;; Get latest exchange rates
  (with-current-buffer (url-retrieve-synchronously "https://api.openrates.io/latest")
    (let* ((exch (json-read))
           (base (intern (cdr (assq 'base exch)))))
      (setq math-additional-units
            (cons
             (list base nil "Base currency")
             (cl-loop for (curr . rate) in (cdr (assq 'rates exch))
                      collect (list curr (format "%f %s" (/ rate) base)
                                    (format "Currency %s in terms of %s" curr base))))
            math-units-table nil))))

(provide 'init-calc)

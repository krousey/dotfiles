(defadvice flyspell-generic-progmode-verify (after my-flyspell-progmode-verify
                                                   activate)
  "Prevent it from spell checking documented variables, functions, and
mixed-case names."
  (when (and ad-return-value
             (or (save-excursion
                   (re-search-forward "\\s-" (line-end-position) 1)
                   (eq (string (char-before (- (point) 1))) ":")) ;; word ends in :
                 (let ((word-tail (substring (thing-at-point 'word) 1)))
                   (not (string= word-tail (downcase word-tail)))))) ;; Camel or UPPER case
    (setq ad-return-value nil)))

(require 'ibuffer)

;; short mode names
(define-ibuffer-column mode-s
  (:name "Mode"
   :inline t
   :header-mouse-map ibuffer-mode-header-map
   :props
   ('mouse-face 'highlight
                'keymap ibuffer-mode-name-map
                'help-echo "mouse-2: filter by this mode"))
  (let ((mname (format-mode-line mode-name nil nil (current-buffer))))
    (cond ((> (length mname) 14)
           (format "%s..." (substring mname 0 11)))
          (t mname))))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size"
   :inline t
   :header-mouse-map ibuffer-size-header-map)
  (cond
   ((> (buffer-size) 1000) (format "%6.2f K" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%6.2f M" (/ (buffer-size) 1000000.0)))
   (t (format "%6d  " (buffer-size)))))

(setq ibuffer-formats '((mark
                         modified
                         read-only " "
                         (name 36 36) " "
                         (size-h 9 -1 :right) " "
                         (mode-s 14 14) " "
                         (process 8 -1) " "
                         (filename 16 -1 :left :elide)))
      ibuffer-saved-filter-groups '(("default"
                                     ("c" (mode . c-mode))
                                     ("c++" (mode . c++-mode))
                                     ("python" (mode . python-mode))
                                     ("haskell" (mode . haskell-mode))
                                     ("go" (mode . go-mode))
                                     ("dired" (mode . dired-mode))
                                     ("emacs" (or (name . "^\\*scratch\\*$")
                                                  (name . "^\\*Messages\\*$")
                                                  (name . "^\\*Completions\\*$")
                                                  (name . "^\\*Backtrace\\*$")
                                                  (mode . emacs-lisp-mode)))
                                     ("special" (name . "^\\*.*\\*$"))))
      ibuffer-elide-long-columns t
      ibuffer-eliding-string "&")

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")
            (let ((blist (ibuffer-current-state-list)))
              (let ((bgroups (ibuffer-generate-filter-groups blist t)))
                (dolist (group bgroups)
                  (let ((name (car group)))
                    (when (and (member name '("dired" "emacs" "special"))
                               (not (member name ibuffer-hidden-filter-groups)))
                      (push name ibuffer-hidden-filter-groups))))))
            (ibuffer-update nil t)))

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)

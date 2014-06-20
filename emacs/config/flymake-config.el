(require 'flymake)

(defun flymake-setup-my-keybindings ()
  (interactive)
  (local-set-key (kbd "M-p")
       (lambda ()
         (interactive)
         (flymake-goto-prev-error)
         (let ((line-err-info (caar (flymake-find-err-info
                                     flymake-err-info
                                     (flymake-current-line-no)))))
           (when line-err-info
             (message "%s"
                      (flymake-ler-text line-err-info))))))

  (local-set-key (kbd "M-n")
       (lambda ()
         (interactive)
         (flymake-goto-next-error)
         (let ((line-err-info (caar (flymake-find-err-info
                                     flymake-err-info
                                     (flymake-current-line-no)))))
           (when line-err-info
             (message "%s"
                      (flymake-ler-text line-err-info)))))))

(add-hook 'flymake-mode-hook 'flymake-setup-my-keybindings)

;; Because this shows up in the fringe
(custom-set-faces
 '(flymake-errline ((((class color)) ())))
 '(flymake-warnline ((((class color)) ()))))

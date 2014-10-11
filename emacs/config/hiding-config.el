(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'go-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)

(defun toggle-hiding ()
  (interactive)
  (when hs-minor-mode
      (if (condition-case nil
              (hs-toggle-hiding)
            (error t))
          (hs-show-all))))

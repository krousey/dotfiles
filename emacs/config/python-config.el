(require 'flymake)

(defun my-python-mode-hook ()
  (flymake-mode 't)
  (let ((whitespace-style '(face indentation lines-tail tabs trailing)))
    (whitespace-mode))
)

(add-hook 'python-mode-hook 'my-python-mode-hook)

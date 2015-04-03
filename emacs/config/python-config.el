(defun my-python-mode-hook ()
  (let ((whitespace-style '(face indentation lines-tail tabs trailing)))
    (whitespace-mode))
)

(add-hook 'python-mode-hook 'my-python-mode-hook)

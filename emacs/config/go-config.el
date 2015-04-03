(require 'go-mode)
(require 'company)
(require 'company-go)
(require 'flycheck)

(add-hook 'before-save-hook 'gofmt-before-save)
(defun my-go-mode-hook ()
  (go-eldoc-setup)
  (flycheck-mode)
  (let ((whitespace-style '(face lines-tail trailing)))
    (whitespace-mode))
  (setq-local tab-width 4)
  (setq-local company-backends '(company-go))
  (company-mode)
)

(add-hook 'go-mode-hook 'my-go-mode-hook)

(defadvice fill-paragraph (around wrap-as-if-tabs-are-eight activate compile)
  "Wrap as if tab width is 8"
  (if (eq major-mode 'go-mode)
      (let ((tab-width 8))
        ad-do-it)
  ad-do-it))

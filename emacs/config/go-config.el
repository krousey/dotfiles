(require 'go-mode)
(require 'go-autocomplete)

;; gocode is overly aggressive in completion
(setq ac-source-go (assq-delete-all 'requires ac-source-go))

(defun flymake-gocheck-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "~/bin/mygocheck" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.go\\'" flymake-gocheck-init))


(add-hook 'before-save-hook 'gofmt-before-save)
(defun my-go-mode-hook ()
  (go-eldoc-setup)
  (flymake-mode)
  (let ((whitespace-style '(face lines-tail trailing)))
    (whitespace-mode))
  (setq-local tab-width 4)
)

(add-hook 'go-mode-hook 'my-go-mode-hook)

(defadvice fill-paragraph (around wrap-as-if-tabs-are-eight activate compile)
  "Wrap as if tab width is 8"
  (if (eq major-mode 'go-mode)
      (let ((tab-width 8))
        ad-do-it)
  ad-do-it))

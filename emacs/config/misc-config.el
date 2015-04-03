(setenv "BASH_ENV" "~/.bashrc")

(setq enable-local-eval t)

;; newlines are required
(setq require-final-newline t)

;; Make text-mode the default major mode
(setq default-major-mode 'text-mode)

;; Use the clipboard
(setq x-select-enable-clipboard t)

;; Autofill to 80
(setq-default fill-column 80)

;; Compilation shouldn't wrap long errors
(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t)))

;; Scroll to first error
(setq-default compilation-scroll-output 'first-error)

;; Better unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(setq uniquify-after-kill-buffer-p t)

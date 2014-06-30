(require 'defshell)

(setq defshell-reuse-buffer nil
      defshell-rename-buffer-uniquely t)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun shell-maybe-up (arg)
  (interactive "p")
  (if (comint-after-pmark-p)
      (comint-previous-input arg)
    (previous-line arg)
    ))

(defun shell-maybe-down (arg)
  (interactive "p")
  (if (comint-after-pmark-p)
      (comint-next-input arg)
    (next-line arg)
    ))

(defshell "/usr/bin/zsh" "Zsh")

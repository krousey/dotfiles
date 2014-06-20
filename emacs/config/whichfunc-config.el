(which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))

(setq which-func-unknown "n/a"
      mode-line-misc-info (assq-delete-all 'which-func-mode mode-line-misc-info))

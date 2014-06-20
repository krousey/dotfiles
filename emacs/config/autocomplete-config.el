(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(setq-default ac-sources '(ac-source-words-in-buffer))
(setq ac-auto-start 2) ;; Only autocomplete after 4 characters
(setq ac-auto-show-menu nil) ;; Never auto show the menu

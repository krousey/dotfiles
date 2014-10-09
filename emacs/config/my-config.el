;; Debug my screwups
;;(setq debug-on-error t)

;; Make mule warnings shutup until I have a chance to track them down.
(setq warning-suppress-types (quote ((mule))))

;; Make sure I have all the packages first
(load-relative-to-current-file "package-config.el")

;; If I'm at work, load up work specific stuff
(when-at-work
 (load-relative-to-current-file "work/work-config.el"))

(load-relative-to-current-file "autocomplete-config.el")
(load-relative-to-current-file "autosave-config.el")
(load-relative-to-current-file "evil-config.el")
(load-relative-to-current-file "flymake-config.el")
(load-relative-to-current-file "flyspell-config.el")
(load-relative-to-current-file "go-config.el")
(load-relative-to-current-file "ibuffer-config.el")
(load-relative-to-current-file "ido-config.el")
(load-relative-to-current-file "hiding-config.el")
(load-relative-to-current-file "js2-config.el")
(load-relative-to-current-file "misc-config.el")
(load-relative-to-current-file "org-config.el")
(load-relative-to-current-file "popwin-config.el")
(load-relative-to-current-file "python-config.el")
(load-relative-to-current-file "scons-config.el")
(load-relative-to-current-file "server-config.el")
(load-relative-to-current-file "shell-config.el")
(load-relative-to-current-file "smex-config.el")
(load-relative-to-current-file "ui-config.el")
(load-relative-to-current-file "whichfunc-config.el")
(load-relative-to-current-file "yaml-config.el")
(load-relative-to-current-file "yasnippet-config.el")

(load-relative-to-current-file "custom-keys-config.el")

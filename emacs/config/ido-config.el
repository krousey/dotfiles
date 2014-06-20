(require 'ido)
(require 'ido-ubiquitous)

(setq ido-enable-tramp-completion nil
      ido-max-work-file-list nil
      ido-max-work-directory-list nil)

(ido-mode t)
(ido-everywhere)
(setq ido-enable-flex-matching t)

(ido-ubiquitous-mode 1)

;; set color defaults
(add-to-list 'custom-theme-load-path (concat my-emacs-root "themes"))
(load-theme 'kris-tsdh-dark t)

;; No splash screen
(setq inhibit-splash-screen t)

;; visual bell!
(setq visible-bell t)

;; get rid of the toolbar, menu bar, and scroll bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; no tiny windows
(setq window-min-height 3)

;; display the column number
(setq column-number-mode t)

;; fix the cursor during page ups and downs
(setq scroll-preserve-screen-position t)

;; I'm not done screwing with the scrolling
(setq scroll-margin 2)

;; the keyboard is mightier than the mouse!
(mouse-avoidance-mode 'jump)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; show matching parenthesis
(show-paren-mode 1)

;; show marked region and let me type over it
(setq transient-mark-mode t)
(delete-selection-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; I often lose track of time
(display-time)

;; Tweaking editing environment
(add-to-list 'default-frame-alist '(alpha . (100 100)))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist
             '(font . "-unknown-Inconsolata-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1"))

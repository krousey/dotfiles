
;; Bootstrap

;; Do not modify this file manually. It was generated from init.org in the same
;; directory. Edit that instead.

;; I use use-package throughout, so let's make sure that it's installed and loaded.

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; I also want to use :diminish with use-package.

(use-package diminish :ensure t)

;; Color theme

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config (load-theme 'sanityinc-tomorrow-night t))

;; Miscellaneous

;; Reduce the clutter.

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq window-min-height 3
      column-number-mode t
      mouse-avoidance-mode 'jump)

;; Autosaves and backups

;; Put them all in the temp directory

(defconst my/emacs-tmp-dir
  (concat temporary-file-directory "emacs_" (user-login-name) "/")
  "Temp directory for me.")

(setq backup-directory-alist         `((".*" . ,my/emacs-tmp-dir))
      auto-save-file-name-transforms `((".*" ,my/emacs-tmp-dir t))
      auto-save-list-file-prefix     my/emacs-tmp-dir)

;; Company mode
;; Code completion

(use-package company
  :ensure t
  :commands (company-mode global-company-mode)
  :diminish company-mode
  :config
  (setq company-minimum-prefix-length 2))

(use-package company-go
  :ensure t
  :commands company-mode)

;; Compilation

(use-package compile
  :config
  (global-set-key (kbd "C-c m") 'compile)
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key "c m" 'compile))
  (setq compilation-scroll-output 'first-error))

;; Eldoc

(use-package eldoc
  :defer t
  :diminish eldoc-mode)

;; Eshell

(use-package eshell
  :commands eshell
  :functions eshell/pwd
  :init
  (defvar my/eshell-prompt-client-path-functions nil
    "A list of functions that take a path and return a list of
client name and remaining path")

  (defun my/eshell-prompt ()
    (let ((path (eshell/pwd))
          (client nil))
      ;; See if our path contains any code clients
      (loop
       for f in my/eshell-prompt-client-path-functions
       while (not client)
       do
       (let ((result (funcall f path)))
         (when result
           (setq client (car result)
                 path (car (cdr result))))))
      (let ((prompt
             ;; user@system [client/]short_path >
             (concat
              (propertize (user-real-login-name)
                          'face '(:weight bold :foreground "SteelBlue2"))
              (propertize "@"
                          'face '(:weight bold :foreground "light sea green"))
              (propertize (car (split-string (system-name) "\\."))
                          'face '(:weight bold :foreground "white"))
              " "
              (when client (propertize client
                                       'face '(:weight bold :foreground "red")))
              (propertize (my/shortened-path path 40)
                          'face '(:weight bold :foreground "light sea green"))
              (if (= (user-uid) 0) " $ " " > "))))
        ;; now make it read-only
        (add-text-properties
         0 (length prompt)
         '(read-only t front-sticky (face read-only) rear-nonsticky (face read-only))
         prompt)
        prompt)))

  (defun my/shortened-path (path max-len)
    "Return a modified version of `path', replacing some components
 with single characters starting from the left to try and get
 the path down to `max-len'"
    (let* ((components (split-string (abbreviate-file-name path) "/"))
           (len (+ (1- (length components))
                   (reduce '+ components :key 'length)))
           (str ""))
      (while (and (> len max-len)
                  (cdr components))
        (setq str (concat str (if (= 0 (length (car components)))
                                  "/"
                                (string (elt (car components) 0) ?/)))
              len (- len (1- (length (car components))))
              components (cdr components)))
      (concat str (reduce (lambda (a b) (concat a "/" b)) components))))

  (setq eshell-prompt-regexp "^[^>$\n]* [>$] ")
  (setq eshell-highlight-prompt nil)
  (setq eshell-prompt-function 'my/eshell-prompt))

;; Evil mode
;; VIM emulation

(use-package evil
  :ensure t
  :config
  (setq evil-default-cursor t)
  (evil-mode 1))

(use-package key-chord  
  :ensure t
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-normal-state-map "jk" 'evil-force-normal-state)
  (key-chord-define evil-visual-state-map "jk" 'evil-change-to-previous-state)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-replace-state-map "jk" 'evil-normal-state))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode t)
  (evil-leader/set-leader "<SPC>"))

(use-package evil-nerd-commenter
  :ensure t
  :config
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key
      "; i" 'evilnc-comment-or-uncomment-lines
      "; l" 'evilnc-comment-or-uncomment-to-the-line
      "; c" 'evilnc-copy-and-comment-lines
      "; p" 'evilnc-comment-or-uncomment-paragraphs
      "; r" 'comment-or-uncomment-region)))

;; Flycheck
;; Continuous checking

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :diminish flycheck-mode
  :config
  (setq flycheck-highlighting-mode nil))

;; Guide Key
;; Helpful reminders of key bindings

(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :config
  (setq guide-key/guide-key-sequence '("C-c" "SPC"))
  (setq guide-key/recursive-key-sequence-flag t)
  (guide-key-mode 1))

;; IDO

(use-package ido
  :ensure t
  :config
  (setq ido-enable-tramp-completion nil
        ido-max-work-file-list nil
        ido-max-work-directory-list nil)
  (ido-mode t)
  (ido-everywhere)
  (setq ido-enable-flex-matching t))

(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous-mode 1))

;; Ibuffer

(use-package ibuffer
  :ensure t
  :commands (ibuffer ibuffer-other-window)
  :config
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key "b" 'ibuffer))

  ;; short mode names
  (define-ibuffer-column mode-s
    (:name "Mode"
           :inline t
           :header-mouse-map ibuffer-mode-header-map
           :props
           ('mouse-face 'highlight
                        'keymap ibuffer-mode-name-map
                        'help-echo "mouse-2: filter by this mode"))
    (let ((mname (format-mode-line mode-name nil nil (current-buffer))))
      (cond ((> (length mname) 14)
             (format "%s..." (substring mname 0 11)))
            (t mname))))

  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size"
           :inline t
           :header-mouse-map ibuffer-size-header-map)
    (cond
     ((> (buffer-size) 1000) (format "%6.2f K" (/ (buffer-size) 1000.0)))
     ((> (buffer-size) 1000000) (format "%6.2f M" (/ (buffer-size) 1000000.0)))
     (t (format "%6d  " (buffer-size)))))

  (setq ibuffer-formats '((mark
                           modified
                           read-only " "
                           (name 36 36) " "
                           (size-h 9 -1 :right) " "
                           (mode-s 14 14) " "
                           (process 8 -1) " "
                           (filename 16 -1 :left :elide)))
        ibuffer-saved-filter-groups '(("default"
                                       ("c" (mode . c-mode))
                                       ("c++" (mode . c++-mode))
                                       ("python" (mode . python-mode))
                                       ("haskell" (mode . haskell-mode))
                                       ("go" (mode . go-mode))
                                       ("dired" (mode . dired-mode))
                                       ("emacs" (or (name . "^\\*scratch\\*$")
                                                    (name . "^\\*Messages\\*$")
                                                    (name . "^\\*Completions\\*$")
                                                    (name . "^\\*Backtrace\\*$")
                                                    (mode . emacs-lisp-mode)))
                                       ("special" (name . "^\\*.*\\*$"))))
        ibuffer-elide-long-columns t
        ibuffer-eliding-string "&")

  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-auto-mode 1)
              (ibuffer-switch-to-saved-filter-groups "default")
              (let ((blist (ibuffer-current-state-list)))
                (let ((bgroups (ibuffer-generate-filter-groups blist t)))
                  (dolist (group bgroups)
                    (let ((name (car group)))
                      (when (and (member name '("dired" "emacs" "special"))
                                 (not (member name ibuffer-hidden-filter-groups)))
                        (push name ibuffer-hidden-filter-groups))))))
              (ibuffer-update nil t)))

  (setq ibuffer-show-empty-filter-groups nil)
  (setq ibuffer-expert t))

;; Hiding

(use-package hideshow
  :diminish hs-minor-mode
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode)
  (defun my/toggle-hiding ()
    (interactive)
    (when hs-minor-mode
      (if (condition-case nil
              (hs-toggle-hiding)
            (error t))
          (hs-show-all))))

  (global-set-key (kbd "C-c h") 'my/toggle-hiding)
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key "h" 'my/toggle-hiding)))

;; Magit

(use-package magit
  :ensure t
  :init
  (setq magit-last-seen-setup-instructions "1.4.0")
  :config
  (setq magit-auto-revert-mode nil))

;; Miscellaneous

(setq enable-local-eval t)
(setq-default major-mode 'text-mode)
(setq x-select-enable-clipboard t)
(setq inhibit-startup-message t)

;; Narrowing

(defun my/narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.
With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

(global-set-key (kbd "C-c n") 'my/narrow-or-widen-dwim)
(with-eval-after-load "evil-leader"
  (evil-leader/set-key
    "n" 'my/narrow-or-widen-dwim))

;; Popwin

(use-package popwin
  :ensure t
  :config
  (push '(compilation-mode :noselect t :stick t :position bottom)
        popwin:special-display-config)
  (push '("*Gofmt Errors*" :noselect t :position bottom)
        popwin:special-display-config)
  (push '("*go-guru-output*" :noselect t :stick t :position bottom)
        popwin:special-display-config)
  (popwin-mode 1))

(use-package import-popwin
  :ensure t
  :config
  (import-popwin:add :mode 'java-mode
                     :regexp "^import\\s")
  (import-popwin:add :mode 'go-mode
                     :regexp "^import\\s"))

;; Smex

(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key
      "x" 'smex
      "X" 'smex-major-mode-commands))
  (smex-initialize))

;; Undo Tree

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)

;; Uniquify

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-after-kill-buffer-p t))

;; Whichfunc

(use-package which-func
  :config
  (setq-default header-line-format
                '((which-func-mode ("" which-func-format " "))))
  (setq which-func-unknown "n/a"
        mode-line-misc-info (assq-delete-all 'which-func-mode mode-line-misc-info))
  (which-function-mode))

;; Whitespace mode

(use-package whitespace
  :commands whitespace-mode
  :diminish whitespace-mode)

;; Windmove

(use-package windmove
  :config
  (setq windmove-wrap-around t)
  (windmove-default-keybindings))

;; YASnippet

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

;; General

(add-hook
 'prog-mode-hook
 (lambda ()
   ;; fix the cursor during page ups and downs
   (setq-local scroll-preserve-screen-position t)
   (setq-local scroll-margin 2)
   
   ;; show matching parenthesis
   (show-paren-mode 1)))

;; Go

(use-package go-eldoc
  :ensure t
  :commands go-eldoc-setup)

(use-package go-guru
  :ensure t
  :config
  (with-eval-after-load "evil-leader"
    (evil-leader/set-key-for-mode 'go-mode
      "g d" 'go-guru-describe
      "g f" 'go-guru-freevars
      "g i" 'go-guru-implements
      "g c" 'go-guru-peers
      "g r" 'go-guru-referrers
      "g j" 'go-guru-definition
      "g p" 'go-guru-pointsto
      "g s" 'go-guru-callstack
      "g e" 'go-guru-whicherrs
      "g <" 'go-guru-callers
      "g >" 'go-guru-callees
      "g x" 'go-guru-expand-region)))

(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config
  (setq gofmt-command "goimports")

  (defun my/go-mode-hook ()
    (go-eldoc-setup)
    (flycheck-mode)
    (go-guru-hl-identifier-mode)
    (let ((whitespace-style '(face lines-tail trailing)))
      (whitespace-mode))
    (setq-local tab-width 4)
    (setq-local company-backends '(company-go))
    (company-mode)
    (add-hook 'before-save-hook 'gofmt-before-save nil t))

  (add-hook 'go-mode-hook 'my/go-mode-hook)

  (defadvice fill-paragraph (around wrap-as-if-tabs-are-eight activate compile)
    "Wrap as if tab width is 8"
    (if (eq major-mode 'go-mode)
        (let ((tab-width 8))
          ad-do-it)
      ad-do-it)))

;; Elisp

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)
            (company-mode)))

;; Sh

(add-hook 'sh-mode-hook
          (lambda ()
            (flycheck-mode)))

;; Org mode

(use-package org
  :ensure t
  :init
  (setq org-replace-disputed-keys t)
  :mode ("\\.org\\'" . org-mode)
  :config
 (define-key global-map (kbd "C-c o l") 'org-store-link)
 (define-key global-map (kbd "C-c o a") 'org-agenda)
 (define-key global-map (kbd "C-c o b") 'org-iswitchb)
 (with-eval-after-load "evil-leader"
   (evil-leader/set-key
     "c o l" 'org-store-link
     "c o a" 'org-agenda
     "c o b" 'org-iswitchb))

  (setq org-startup-indented t)
  (setq org-src-fontify-natively t)
  (setq org-src-window-setup 'other-window)
  (org-babel-do-load-languages
   (quote org-babel-load-languages)
   (quote ((emacs-lisp . t)
           (dot . t)
           (ditaa . t)
           (R . t)
           (python . t)
           (ruby . t)
           (gnuplot . t)
           (clojure . t)
           (sh . t)
           (ledger . t)
           (org . t)
           (latex . t)))))
  
(use-package org-indent-mode
  :defer t
  :diminish org-indent-mode)

;; Local customizations

(let ((local-init-file (concat user-emacs-directory "local.el")))
  (when (file-exists-p local-init-file)
    (load-file local-init-file)))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

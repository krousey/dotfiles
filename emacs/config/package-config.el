(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar kris/my-packages
  '(company
    company-go
    evil
    evil-nerd-commenter
    evil-leader
    flycheck
    fringe-helper
    ghc
    ghci-completion
    git-gutter
    git-gutter-fringe
    go-eldoc
    go-mode
    graphviz-dot-mode
    haskell-mode
    ido-ubiquitous
    import-popwin
    js2-mode
    key-chord
    magit
    multi-term
    multiple-cursors
    org
    popup
    popwin
    smex
    yaml-mode
    yasnippet)
  "A list of packages to ensure are installed at launch.")

(defun kris/my-packages-installed-p ()
  (loop for p in kris/my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (kris/my-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p kris/my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

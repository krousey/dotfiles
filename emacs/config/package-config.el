(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("ELPA" . "http://tromey.com/elpa") t)

(package-initialize)

(defvar kris/my-packages
  '(ac-js2
    ac-math
    auto-complete
    auto-complete-clang
    evil
    evil-nerd-commenter
    evil-leader
    fringe-helper
    ghc
    ghci-completion
    git-gutter
    git-gutter-fringe
    go-autocomplete
    go-eldoc
    go-mode
    graphviz-dot-mode
    haskell-mode
    ido-ubiquitous
    import-popwin
    js2-mode
    key-chord
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

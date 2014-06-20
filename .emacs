;;; ~/.emacs

;; Environment setup and platform-convenience macros
(defvar running-ms-windows
  (or (eq system-type `windows-nt) (eq system-type 'cygwin)))

(defvar running-gnu-linux
  (eq system-type 'gnu/linux))

(defvar running-mac-osx
  (or (eq system-type 'darwin) (eq system-type 'ns)))

(defvar running-at-work
  (file-exists-p "~/.at_work"))

(defmacro when-ms-windows (&rest body)
  (list 'if running-ms-windows (cons 'progn body)))

(defmacro when-gnu-linux (&rest body)
  (list 'if running-gnu-linux (cons 'progn body)))

(defmacro when-mac-osx (&rest body)
  (list 'if running-mac-osx (cons 'progn body)))

(defmacro when-at-work (&rest body)
  (list 'if running-at-work (cons 'progn body)))

(defmacro unless-at-work (&rest body)
  (list 'unless running-at-work (cons 'progn body)))

(defun fullpath-relative-to-current-file (file-relative-path)
  (expand-file-name file-relative-path (file-name-directory (or load-file-name buffer-file-name))))

(defun load-relative-to-current-file (file-relative-path)
  (load-file (fullpath-relative-to-current-file file-relative-path)))

(defvar my-emacs-root (fullpath-relative-to-current-file "emacs/") "The root of my emacs config.")

(add-to-list 'load-path (concat my-emacs-root "site-lisp"))

(load-relative-to-current-file (concat my-emacs-root "config/my-config.el"))

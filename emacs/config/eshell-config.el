(require 'eshell)

(defvar prompt-client-path-functions nil
  "A list of functions that take a path and return a list of
client name and remaining path")


(setq eshell-prompt-regexp "^[^>$\n]* [>$] ")
(setq eshell-highlight-prompt nil)

(defun my-eshell-prompt ()
  (let ((path (eshell/pwd))
        (client nil))
    ;; See if our path contains any code clients
    (loop
     for f in prompt-client-path-functions
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
            (propertize (shortened-path path 40)
                        'face '(:weight bold :foreground "light sea green"))
            (if (= (user-uid) 0) " $ " " > "))))
      ;; now make it read-only
      (add-text-properties 0 (length prompt)
                           '(read-only t front-sticky (face read-only) rear-nonsticky (face read-only))
                           prompt)
      prompt)))

(defun shortened-path (path max-len)
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

(setq eshell-prompt-function 'my-eshell-prompt)

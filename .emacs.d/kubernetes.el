(dir-locals-set-class-variables
 'kubernetes-project
 '((nil . ((grep-find-template . "find . <X> -type f <F> -exec grep <C> -nHI -e <R> {} +")
	   (grep-find-ignored-directories . (".git" "_output" "Godeps"))))
   (go-mode . ((go-oracle-scope . ".")))))

;; Put this in local.el and make sure the path is right
;; (load-file (concat user-emacs-directory "kubernetes.el"))
;; (dir-locals-set-directory-class
;;  (expand-file-name "PATH_TO_KUBERNETES_SOURCE")
;;  'kubernetes-project)

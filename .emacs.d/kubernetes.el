(defun my/kubernetes-go-oracle-scope ()
  "Returns a space separated string of scopes for go oracle to use"
  (let ((kuberenetes-packages (shell-command-to-string "go list -f '{{if eq .Name \"main\"}}{{.ImportPath}}{{end}}' github.com/GoogleCloudPlatform/kubernetes/...")))
    (replace-regexp-in-string "\n" " " kuberenetes-packages)))

(dir-locals-set-class-variables
 'kubernetes-project
 '((go-mode
    .
    ((eval
      .
      (setq-local go-oracle-scope (my/kubernetes-go-oracle-scope)))))))

;; Put this in local.el and make sure the path is right
;; (load-file (concat user-emacs-directory "kubernetes.el"))
;; (dir-locals-set-directory-class
;;  (expand-file-name "PATH_TO_KUBERNETES_SOURCE")
;;  'kubernetes-project)

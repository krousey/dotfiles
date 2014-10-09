;; Remap global keys

;; ibuffer keys
(global-set-key (kbd "C-x C-b") 'ibuffer)
(eval-after-load "evil-leader"
  (evil-leader/set-key "b" 'ibuffer))

;; smex keys
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(eval-after-load "evil-leader"
  (evil-leader/set-key "x" 'smex
                       "X" 'smex-major-mode-commands))

;; misc navigation keys
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [del] 'delete-char)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; text adjustment keys
(global-set-key [C-kp-add] 'text-scale-increase)
(global-set-key [C-kp-subtract] 'text-scale-decrease)
(global-set-key (kbd "<C-S-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-S-mouse-5>") 'text-scale-decrease)

;; window navigation keys
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; org keybindings
(define-key global-map (kbd "C-c o l") 'org-store-link)
(define-key global-map (kbd "C-c o a") 'org-agenda)
(define-key global-map (kbd "C-c o b") 'org-iswitchb)
(eval-after-load "evil-leader"
  (evil-leader/set-key "c o l" 'org-store-link
                       "c o a" 'org-agenda
                       "c o b" 'org-iswitchb))

;; shell keybindings
(define-key shell-mode-map [up] 'shell-maybe-up)
(define-key shell-mode-map [down] 'shell-maybe-down)

;; autocomplete key map
(define-key ac-mode-map  [(control tab)] 'auto-complete)

;; popwin prefix
(global-set-key (kbd "C-p") popwin:keymap)

;; evil nerd commenter
(eval-after-load "evil-leader"
  (evil-leader/set-key "; i" 'evilnc-comment-or-uncomment-lines
                       "; l" 'evilnc-comment-or-uncomment-to-the-line
                       "; c" 'evilnc-copy-and-comment-lines
                       "; p" 'evilnc-comment-or-uncomment-paragraphs
                       "; r" 'comment-or-uncomment-region))

;; Probably don't want this at work. Definitely not pastie.
(unless-at-work
 (global-set-key (kbd "C-c m") 'compile)
 (global-set-key (kbd "C-c p") 'pastie-region)
 (eval-after-load "evil-leader"
   (evil-leader/set-key
    "c m" 'compile
    "c p" 'pastie-region)))

;; code folding
(global-set-key (kbd "C-c h") 'toggle-hiding)
(eval-after-load "evil-leader"
  (evil-leader/set-key
    "h" 'toggle-hiding))

;; narrowing
(defun narrow-or-widen-dwim (p)
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

(global-set-key (kbd "C-c n") 'narrow-or-widen-dwim)
(eval-after-load "evil-leader"
  (evil-leader/set-key
    "n" 'narrow-or-widen-dwim))

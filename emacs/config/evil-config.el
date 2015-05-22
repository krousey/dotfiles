(require 'evil)
(require 'evil-surround)
(require 'key-chord)
(require 'evil-leader)
(require 'evil-nerd-commenter)

(setq evil-default-cursor t)
(evil-mode 1)

(key-chord-mode 1)
(key-chord-define evil-normal-state-map "jk" 'evil-force-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-change-to-previous-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-replace-state-map "jk" 'evil-normal-state)
(setq key-chord-two-keys-delay 0.2)

(global-evil-surround-mode 1)

(global-evil-leader-mode t)

(evil-leader/set-leader "<SPC>")

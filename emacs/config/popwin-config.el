(require 'popwin)
(require 'import-popwin)
(push '(compilation-mode :noselect t :stick t :position bottom)
      popwin:special-display-config)
(push '("*Gofmt Errors*" :noselect t :position bottom)
      popwin:special-display-config)


(setq popwin:reuse-window nil)

(setq import-popwin:position 'top)
(setq import-popwin:height 0.15)

(import-popwin:add :mode 'java-mode
                   :regexp "^import\\s")

(import-popwin:add :mode 'go-mode
                   :regexp "^import\\s")

(popwin-mode 1)

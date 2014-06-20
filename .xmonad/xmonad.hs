import Data.Ratio ((%))
import XMonad
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.Volume
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Reflect
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig

import Text.Regex.Posix ((=~))
q ~? x = fmap (=~ x) q

main = xmonad $ myConfig

myConfig = withUrgencyHook NoUrgencyHook $ gnomeConfig
    {
    modMask = myModMask
    , terminal = myTerminal
    , borderWidth = 1
    , layoutHook = myLayout
    , manageHook = myManage
    , handleEventHook = myHandleEventHook
    , workspaces = myWorkspaces
    }
    `additionalKeys`
    [ ((myModMask, xK_b), sendMessage $ ToggleStruts) -- M-b toggle docking area
    , ((myModMask, xK_u), focusUrgent) -- Focus Urgent
    , ((0, xK_F8), myMute) -- mute volume
    , ((0, xK_F9), myVolDown) -- volume down
    , ((0, xK_F10), myVolUp) -- volume up
    , ((myModMask,                 xK_Right), sendMessage $ Go R)
    , ((myModMask,                 xK_Left ), sendMessage $ Go L)
    , ((myModMask,                 xK_Up   ), sendMessage $ Go U)
    , ((myModMask,                 xK_Down ), sendMessage $ Go D)
    , ((myModMask .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((myModMask .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((myModMask .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((myModMask .|. controlMask, xK_Down ), sendMessage $ Swap D)
    ]
    `additionalMouseBindings`
    [ ((myModMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]


myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9:chat"]

myModMask = mod3Mask -- Use right alt instead of left alt

myTerminal = "urxvt"

myLayout = onWorkspace "9:chat" imLayout $ standardLayout
  where
    tiled = Tall 1 (3/100) (1/2)
    grid = GridRatio (16/10)
    standardLayout = avoidStruts $ smartBorders $ windowNavigation $ (tiled ||| Mirror tiled ||| grid ||| Full)
    myTheme = defaultTheme
              { inactiveColor = "#111111"
              }
    imLayout = reflectHoriz $ avoidStruts $ smartBorders $ windowNavigation $ 
               simpleDeco shrinkText myTheme $ spacing 3 $
               withIM (0.18) (Title "Hangouts") (grid ||| tiled)

myManage = manageHook gnomeConfig <+> manageDocks <+> composeAll
  [
  role =? "pop-up" <&&> notChat --> doFloat
  , chat            --> doShift "9:chat" -- chat
  ]
  where role = stringProperty "WM_WINDOW_ROLE"
        chat = appName ~? "crx_.*"
        notChat = not `fmap` chat

myHandleEventHook = handleEventHook gnomeConfig <+> docksEventHook


-- Multimedia Controls
volumeChannels = ["Master", "Headphone", "Speaker", "PCM"]

myMute = toggleMuteChannels volumeChannels >> return ()
myVolUp = raiseVolumeChannels volumeChannels 4 >> setMuteChannels volumeChannels False >> return ()
myVolDown = lowerVolumeChannels volumeChannels 4 >> return ()

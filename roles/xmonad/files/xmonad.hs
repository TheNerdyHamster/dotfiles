-------------
-- Imports --
-------------
import XMonad

-- Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicProjects

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Minimize
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

-- Utils
import XMonad.Util.EZConfig
import XMonad.Util.NamedActions
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Layout
import XMonad.Layout.FixedColumn
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- DBus
import qualified DBus as D
import qualified DBus.Client as D
import qualified XMonad.Layout.BoringWindows as B

-- System
import System.Exit
import Graphics.X11.ExtraTypes.XF86
import System.IO (hClose)

-- Data
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Ratio ((%))

-- Codec
import qualified Codec.Binary.UTF8.String as UTF8

----------
-- MAIN --
----------

main :: IO ()
main = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad
    $ withUrgencyHook NoUrgencyHook
    $ ewmh
    -- $ addDescrKeys ((myModMask, xK_F1), xMessage) myAdditionalKeys
    $ addDescrKeys ((myModMask, xK_F1), showKeybindings) myAdditionalKeys
    $ myConfig { logHook = dynamicLogWithPP (myLogHook dbus) }

-----------------
-- CUSTOM VARS --
-----------------

-- General
myTerminal      = "kitty"
myModMask       = mod4Mask
myBorderWidth   = 2
myBrowser       = "firefox"
mySpacing :: Int
mySpacing       = 5
myLargeSpacing :: Int
myLargeSpacing  = 25
noSpacing :: Int
noSpacing       = 0
prompt          = 20

-- Colours
fg        = "#ebdbb2"
bg        = "#282828"
gray      = "#a89984"
bg1       = "#3c3836"
bg2       = "#505050"
bg3       = "#665c54"
bg4       = "#7c6f64"

green     = "#b8bb26"
darkgreen = "#98971a"
red       = "#fb4934"
darkred   = "#cc241d"
yellow    = "#fabd2f"
blue      = "#83a598"
purple    = "#d3869b"
aqua      = "#8ec07c"
white     = "#eeeeee"

pur2      = "#5b51c9"
blue2     = "#2266d0"

-- Font
myFont = "xft:FiraCode Nerd Font Mono:" ++ "fontformat=truetype:size=10:antialias=true"

------------
-- Layout --
------------

myLayouts = renamed [CutWordsLeft 1] . avoidStruts . minimize . B.boringWindows $ perWS

-- layout per workspace
perWS = onWorkspace wsGEN my3FT $
        onWorkspace wsWRK myAll $
        onWorkspace wsSYS myFTM $
        onWorkspace wsMED my3FT $
        onWorkspace wsTMP myFTM $
        onWorkspace wsGAM myFT  $
        myAll -- all layouts for all other workspaces


myFT  = myTile ||| myFull
myFTM = myTile ||| myFull ||| myMagn
my3FT = myTile ||| myFull ||| my3cmi
myAll = myTile ||| myFull ||| my3cmi ||| myMagn

myFull = renamed [Replace "Full"] $ spacing 0 $ noBorders Full
myTile = renamed [Replace "Main"] $ spacing mySpacing $ Tall 1 (3/100) (1/2)
my3cmi = renamed [Replace "3Col"] $ spacing mySpacing $ ThreeColMid 1 (3/100) (1/2)
myMagn = renamed [Replace "Mag"]  $ noBorders $ limitWindows 3 $ magnifiercz' 1.4 $ FixedColumn 1 20 80 10

------------
-- THEMES --
------------

----------------
-- WORKSPACES --
----------------
wsGEN = "\xf269"
wsWRK = "\xf02d"
wsSYS = "\xf300"
wsMED = "\xf001"
wsTMP = "\xf2db"
wsGAM = "\xf11b"

myWorkspaces :: [String]
myWorkspaces = [wsGEN, wsWRK, wsSYS, wsMED, wsTMP, wsGAM, "7", "8", "9"]

-----------------
-- KEYBINDINGS --
-----------------
showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe "zenity --text-info --font=adobe courier"
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()

myAdditionalKeys c = (subtitle "Custom Keys":) $ mkNamedKeymap c $
  myProgramKeys ++ myWindowManagerKeys ++ myMediaKeys

myProgramKeys =
  [ ("M-z"        , addName "Open calendar & todo list" $ spawn "kitty -e nvim ~/Documents/wiki/index.wiki")
  , ("M-S-x"      , addName "Lock computer" $ spawn "slock")
  , ("M-S-s"      , addName "Sleep" $ spawn "systemctl suspend")
  , ("M-f"        , addName "Open firefox" $ spawn myBrowser)
  , ("M-g"        , addName "Open terminal" $ spawn myTerminal)
  ]

myWindowManagerKeys =
  [ ("M-b"        , addName "Do (not) respect polybar" $ sendMessage ToggleStruts)
  , ("M-S-b"      , addName "Increase spacing between windows" $ incSpacing mySpacing)
  , ("M-v"        , addName "Set default spacing between windows" $ setSpacing mySpacing)
  , ("M-S-v"      , addName "Decrease spacing between windows" $ incSpacing (-mySpacing))
  , ("M-c"        , addName "Set to default large spacing between windows" $ setSpacing myLargeSpacing)
  , ("M-S-h"      , addName "Move to previous non empty workspace" $ moveTo Prev NonEmptyWS)
  , ("M-S-l"      , addName "Move to next non empty workspace" $ moveTo Next NonEmptyWS)
  ]

myMediaKeys =
  [ ("<XF86MonBrightnessUp>"   , addName "Increase backlight" $ spawn "xbacklight -inc 10")
  , ("<XF86MonBrightnessDown>" , addName "Decrease backlight" $ spawn "xbacklight -dec 10")
  -- mpc
  , ("<XF86AudioPrev>"         , addName "Previous track" $ spawn "mpc prev")
  , ("<XF86AudioNext>"         , addName "Next track" $ spawn "mpc next")
  , ("<XF86AudioPlay>"         , addName "Toggle play/pause" $ spawn "mpc toggle")
  -- volume
  , ("<XF86AudioRaiseVolume>"  , addName "Raise volume" $ spawn "pactl set-sink-volume 1 +5%")
  , ("<XF86AudioLowerVolume>"  , addName "Lower volume" $ spawn "pactl set-sink-volume 1 -5%")
  , ("<XF86AudioMute>"         , addName "Toggle mute" $ spawn "pactl set-sink-mute 1 toggle")
  ]

-----------------------------------------------------------------------------}}}
-- MANAGEHOOK                                                                {{{
--------------------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , className =? "Gimp"             --> doFloat
    , resource  =? "desktop_window"   --> doIgnore
    , title     =? "Picture-in-Picture" --> doFloat
    , className =? "feh"              --> doFloat
    , className =? "Gpick"            --> doFloat
    , role      =? "pop-up"           --> doFloat ]
  where
    role = stringProperty "WM_WINDOW_ROLE"

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]

-----------------------------------------------------------------------------}}}
-- LOGHOOK                                                                   {{{
--------------------------------------------------------------------------------
myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ blue2 ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ blue ++ "} ") " %{F-}"
    , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
    , ppHidden = wrap " " " "
    , ppWsSep = ""
    , ppSep = " | "
    , ppTitle = myAddSpaces 25
    }

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str

-----------------
-- STARTUPHOOK --
-----------------

myStartupHook = do
  setWMName "LG3D"
  spawn "$HOME/dotfiles/.config/polybar/launch.sh"
  spawnOnce "feh --bg-fill /usr/share/backgrounds/archlinux/snow.jpg" -- Set background
  spawnOnce "picom &" -- Enable compositor
  spawnOnce "xss-lock -- slock &" -- Enable lockscreen

------------
-- CONFIG --
------------

myConfig = def
  { terminal            = myTerminal
  , layoutHook          = myLayouts
  , manageHook          = placeHook(smart(0.5, 0.5))
      <+> manageDocks
      <+> myManageHook
      <+> myManageHook'
      <+> manageHook def
  , handleEventHook     = docksEventHook
      <+> minimizeEventHook
      <+> fullscreenEventHook
  , startupHook         = myStartupHook
  , focusFollowsMouse   = False
  , clickJustFocuses    = False
  , borderWidth         = myBorderWidth
  , normalBorderColor   = bg
  , focusedBorderColor  = pur2
  , workspaces          = myWorkspaces
  , modMask             = myModMask
  }

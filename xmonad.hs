import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Monoid

import XMonad.Actions.CycleWS
import XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.SinkAll
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowArranger
import XMonad.Layout.Mosaic

import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Window

import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WorkspaceCompare
import XMonad.Util.XSelection

import XMonad.Config.Gnome

-- Mod4 is the Super / Windows key
winMask = mod4Mask
altMask = mod1Mask

-- key bindings
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((winMask,                    xK_Return   ), spawn $ XMonad.terminal conf)

    -- download selected link
    -- launch seltr
    , ((winMask,                    xK_z        ), spawn "seltr")
    , ((winMask,                    xK_F1       ), spawn "nautilus ~")
    , ((winMask,                    xK_F2       ), runOrRaise "firefox" (className =? "Firefox"))
    , ((winMask,                    xK_F3       ), runOrRaise "thunderbird" (className =? "Thunderbird"))
    , ((winMask,                    xK_F12      ), runOrRaise "VirtualBox" (className =? "VirtualBox"))
    , ((winMask,                    xK_p    ), runOrRaisePrompt mySP)
    , ((winMask .|. shiftMask,      xK_space    ), shellPrompt mySP)
    , ((winMask .|. controlMask,    xK_space    ), windowPromptGoto mySP)

    , ((winMask,                    xK_Tab      ), sendMessage NextLayout >> (dynamicLogString myPP >>= \d->safeSpawn "gnome-osd-client" [d]))
    , ((altMask,                    xK_Tab      ), windows W.focusDown)
    , ((altMask .|. shiftMask,      xK_Tab      ), windows W.focusUp)
    , ((controlMask,                xK_Down     ), windows W.swapDown)
    , ((controlMask,                xK_Up       ), windows W.swapUp)
    , ((winMask,                    xK_h        ), sendMessage Shrink)
    , ((winMask,                    xK_l        ), sendMessage Expand)
    , ((winMask,                    xK_j        ), sendMessage MirrorShrink)
    , ((winMask,                    xK_k        ), sendMessage MirrorExpand)
    , ((winMask,                    xK_minus    ), windows W.shiftMaster)
    , ((winMask,                    xK_comma    ), sendMessage (IncMasterN 1))
    , ((winMask,                    xK_period   ), sendMessage (IncMasterN (-1)))
    , ((winMask,                    xK_n        ), refresh)
    , ((winMask .|. shiftMask,      xK_n        ), setLayout $ XMonad.layoutHook conf)
    , ((winMask,                    xK_m        ), sendMessage (Toggle "Full") >> (dynamicLogString myPP >>= \d->safeSpawn "gnome-osd-client" [d]))
    , ((winMask,                    xK_t        ), withFocused $ windows . W.sink)
    , ((winMask .|. shiftMask,      xK_t        ), sinkAll)
    , ((winMask,                    xK_f        ), sendMessage ToggleStruts)
    , ((winMask,                    xK_w        ), kill)
    , ((winMask,                    xK_q        ), broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]

    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [ ((m .|. winMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)] ]

-- mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((winMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((winMask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((winMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]

-- decoration theme
myDeco = defaultTheme
    { activeColor           = "orange"
    , inactiveColor         = "#222222"
    , urgentColor           = "yellow"
    , activeBorderColor     = "orange"
    , inactiveBorderColor   = "#222222"
    , urgentBorderColor     = "yellow"
    , activeTextColor       = "orange"
    , inactiveTextColor     = "#222222"
    , urgentTextColor       = "yellow"
    , decoHeight            = 10 }

-- tab theme
myTab = defaultTheme
    { activeColor           = "black"
    , inactiveColor         = "black"
    , urgentColor           = "yellow"
    , activeBorderColor     = "orange"
    , inactiveBorderColor   = "#222222"
    , urgentBorderColor     = "black"
    , activeTextColor       = "orange"
    , inactiveTextColor     = "#222222"
    , urgentTextColor       = "yellow" }

-- shell prompt theme
mySP = defaultXPConfig
    { bgColor               = "black"
    , fgColor               = "white"
    , bgHLight              = "gray"
    , fgHLight              = "black"
    , borderColor           = "orange"
    , promptBorderWidth     = 2
    , position              = Bottom
    , height                = 40
    --, autoComplete        = Just 1000
    , historySize           = 1000 }

-- dynamicLog theme (suppress everything but layout)
myPP = defaultPP
    { ppLayout  = (\ x -> case x of
      "Hinted ResizableTall"        -> "[|]"
      "Mirror Hinted ResizableTall" -> "[-]"
      "Hinted Tabbed Simplest"      -> "[T]"
      "Mosaic"                      -> "[M]"
      "Full"                 -> "[ ]"
      _                      -> x )
    , ppCurrent             = const ""
    , ppVisible             = const ""
    , ppHidden              = const ""
    , ppHiddenNoWindows     = const ""
    , ppUrgent              = const ""
    , ppTitle               = const ""
    , ppWsSep               = ""
    , ppSep                 = "" }

-- layouts
myLayout = avoidStruts $ toggleLayouts (noBorders Full)
    (smartBorders (tiled ||| mosaic 2 [3,2] ||| Mirror tiled ||| layoutHints (tabbed shrinkText myTab)))
    where
        tiled   = layoutHints $ ResizableTall nmaster delta ratio []
        nmaster = 1
        delta   = 2/100
        ratio   = 1/2

-- special windows
myManageHook = composeAll
    [ className =? "MPlayer"                --> doFloat
    , className =? "Gimp-2.6"               --> doFloat
    , className =? "Gnome-panel"            --> doIgnore
    , className =? "XVkbd"                  --> doIgnore
    , className =? "Cellwriter"             --> doIgnore
    , className =? "Gtkdialog"              --> doFloat
    , resource  =? "desktop_window"         --> doIgnore
    , className  =? "Xmessage"              --> doCenterFloat
    , className =? "Unity-2d-panel"         --> doIgnore
    , isFullscreen                          --> doFullFloat
    , isDialog                              --> doCenterFloat
    , title =? "RSSOwl"                     --> doIgnore
    , title =? "Dbeaver"                    --> doIgnore
    , title =? "Xmind-bin"                  --> doIgnore
    , title =? "AptanaStudio3"              --> doIgnore
    , resource =? "sun-awt-X11-XDialogPeer" --> doCenterFloat
    , title =? "screenkey"                  --> doIgnore
    , className =? "Gloobus-preview"        --> doCenterFloat
    --                                      x y w h
    , scratchpadManageHook $ W.RationalRect 0 0 1 0.42
    , manageDocks ] <+> manageHook defaultConfig

-- let Gnome know about Xmonad actions
myLogHook = ewmhDesktopsLogHookCustom scratchpadFilterOutWorkspace >> updatePointer (Relative 0.5 0.5)

myConfig = ewmh defaultConfig
    { terminal           = "terminator"
    , borderWidth        = 1
    , normalBorderColor  = "black"
    , focusedBorderColor = "orange"
    , focusFollowsMouse  = True
    , modMask            = mod4Mask
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , startupHook        = gnomeRegister
    }

-- need to override ewmh's logHook cause I'm using Scratchpad
main = xmonad $ myConfig
    { logHook            = myLogHook }

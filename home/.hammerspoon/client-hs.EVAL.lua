-- USAGE:
--   m4_shim \
--     "+8" "home/.hammerspoon/client-hs.EVAL.lua" \
--     "home/.hammerspoon/client-hs.lua"

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- vim:tw=0:ts=2:sw=2:et:norl:nospell:ft=lua
-- DXY_HEADER_AUTHOR
-- DXY_HEADER_PROJECT
-- DXY_HEADER_LICENSE

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- CXREF:
--
--   ~/.kit/mOS/macOS-Hammyspoony/.hammerspoon/init.lua
--
--   ~/.depoxy/ambers/home/.hammerspoon/depoxy-hs.lua
--
-- SAVVY: This module can access functions defined by either file,
-- macOS-Hammyspoony's init.lua, as well as from depoxy-hs.lua.

-- USYNC/2024-10-22: Merge useful changes back to the template:
--
local __USYNC__ = [[
  meld \
    ~/.depoxy/ambers/archetype/home/.hammerspoon/client-hs.EVAL.lua \
    ~/.depoxy/stints/DXY_DEPOXY_CLIENT_ID/home/.hammerspoon/client-hs.lua &
]]

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- CPYST: Use hs.alert.show to trace code.
--
--   hs.alert.show("CLIENT Reporting!")
--
-- Or uncomment to verify this file gets loaded.

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- +++ Alacritty fronters

-- USAGE: If you ssh to a host that doesn't honor the window number,
-- you could always use the same window to access the host, and then
-- use the hostname in the title to find the window.
--
-- - E.g.,
--
--   -- BNDNG: <Cmd-8>
--   hs.hotkey.bind({"cmd"}, "8", function()
--     local win_hint = "myhost"
--
--     frillsAlacrittyAndTerminal:alacritty_by_window_number_prefix(8, win_hint)
--   end)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- +++ GVim openers

-- # *** Personal docs GVim openers.

-- Open @Your Backlog in MacVim
-- BNDNG: <Shift-Cmd-W>
hs.hotkey.bind({"shift", "cmd"}, "W", function()
  gvim_open_kindness("DXY_DEPOXY_CLIENT_TILDE/private/docs/Backlog_Personal_[[[]]]DXY_DEPOXY_CLIENT_ID.rst")
end)

-- Open @Your Woodlot in MacVim
-- BNDNG: <Ctrl-Cmd-W>
hs.hotkey.bind({"ctrl", "cmd"}, "W", function()
  gvim_open_kindness("DXY_DEPOXY_CLIENT_TILDE/private/docs/Woodlot_Personal_[[[]]]DXY_DEPOXY_CLIENT_ID.rst")
end)

-- # *** Work notes GVim openers.

-- Open @Work Backlog in MacVim
-- BNDNG: <Cmd-E>
hs.hotkey.bind({"cmd"}, "E", function()
  gvim_open_kindness("DXY_DEPOXY_CLIENT_TILDE/docs/Backlog_Client_[[[]]]DXY_DEPOXY_CLIENT_ID.rst")
end)

-- Open @Work Woodlot in MacVim
-- BNDNG: <Ctrl-Cmd-E>
hs.hotkey.bind({"ctrl", "cmd"}, "E", function()
  gvim_open_kindness("DXY_DEPOXY_CLIENT_TILDE/docs/Woodlot_Client_[[[]]]DXY_DEPOXY_CLIENT_ID.rst")
end)

-------

-- Open macOS Onboarding document in MacVim
-- BNDNG: <Cmd-O>
local cmd_o = hs.hotkey.bind({"cmd"}, "O", function()
  gvim_open_kindness("~/.depoxy/ambers/docs/README-macOS-onboarding.rst")
end)

-- Note that DepoXy changes all <Cmd-O> app bindings to <Ctrl-O>,
-- so that, e.g., typically Open is remapped to <Ctrl-O>, and
-- <Cmd-O> is free for us to use.
-- - But for some apps we want the actual <Cmd> event to be generated.
ignore_hotkey_gnucash(cmd_o)
ignore_hotkey_slack(cmd_o)

-------

-- USAGE: If you add <Cmd-I> accelerator, be sure to disable for
-- some apps.
--
-- - E.g.,
--
--   -- BNDNG: <Cmd-I>
--   local cmd_i = hs.hotkey.bind({"cmd"}, "I", function()
--     gvim_open_kindness("~/path/to/file")
--   end)
--
--   ignore_hotkey_gnucash(cmd_i)
--   ignore_hotkey_meld(cmd_i)
--   ignore_hotkey_slack(cmd_i)

-- Likewise <Cmd-W>.
--
-- - E.g.,
--
--   -- BNDNG: <Cmd-W>
--   local cmd_w = hs.hotkey.bind({"cmd"}, "W", function()
--     gvim_open_kindness("~/path/to/file")
--   end)
--
--   ignore_hotkey_gnucash(cmd_w)
--   ignore_hotkey_meld(cmd_w)
--   ignore_hotkey_slack(cmd_w)

-- And <Cmd-Z>.
--
-- - E.g.,
--
--   -- BNDNG: <Cmd-Z>
--   local cmd_z = hs.hotkey.bind({"cmd"}, "Z", function()
--     gvim_open_kindness("~/path/to/file")
--   end)
--
--   ignore_hotkey_gnucash(cmd_z)
--   ignore_hotkey_libreoffice(cmd_z)
--   ignore_hotkey_meld(cmd_z)
--   ignore_hotkey_slack(cmd_z)

-- Ditto <Shift-Cmd-E>
--
-- - E.g.,
--
--   -- BNDNG: <Cmd-Z>
--   local shift_cmd_e = hs.hotkey.bind({"shift", "cmd"}, "E", function()
--     gvim_open_kindness("~/path/to/file")
--   end)
--
--   ignore_hotkey_slack(shift_cmd_e)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
-- +++ Browser window openers

-- EmojiCombos
-- BNDNG: <Cmd-Alt-E>
hs.hotkey.bind({"cmd", "alt"}, "E", function()
  browserWindowFronters:browserWindowFrontOrOpen(
    "https://emojicombos.com/",
    {
      "Emoji Combos",
    }
  )
end)

-- BNDNG: <Shift-Cmd-Alt-E>
hs.hotkey.bind({"shift", "cmd", "alt"}, "E", function()
  browserWindowFronters:browserWindowFrontOrOpen(
    "https://instafonts.io/",
    {
      "Fonts & Text Symbols (",
    }
  )
end)

-------

-- The Current foregrounder/๏קєภer
--   https://www.thecurrent.org/listen
--   https://radiok.org/
--   https://kfai.org/
--     https://www.radiorethink.com/tuner/index.cfm?stationCode=kfai
-- BNDNG: <Shift-Ctrl-Cmd-C>
hs.hotkey.bind({"shift", "ctrl", "cmd"}, "C", function()
  local toggle = true

  browserWindowFronters:browserWindowFrontOrOpen(
    "https://www.thecurrent.org/listen",
    {
      "Listen to The Current",
      "Radio K",
      "KFAI | Minneapolis & Saint Paul",
    },
    toggle
  )
end)

-------

-- CPYST: Identify profile account, e.g.,
--   $ jq -sr '.[0].account_info[0].email' \
--     "${HOME}/Library/Application Support/Google/Chrome/Profile 2/Preferences"
--   foo@gmail.com
--   $ jq -sr '.[0].account_info[0].email' \
--     "${HOME}/Library/Application Support/Google/Chrome/Profile 3/Preferences"
--   bar@gmail.com

-- BNDNG: <Alt-Cmd-T>
hs.hotkey.bind({"cmd", "alt"}, "T", function()
  frillsChrome:makeNewChromeWindow("Profile 2")
end)

-------

-- USAGE: If you use different Chrome profiles, you could have different
-- bindings for different Gmail inboxes.
--
-- - E.g.,
--
--   -- CPYST: Identify profile account, e.g.,
--   --   $ jq -sr '.[0].account_info[0].email' \
--   --     "${HOME}/Library/Application Support/Google/Chrome/Profile 1/Preferences"
--   --   user2@gmail.com
--
--   -- Bring front/focus specific user email window.
--   -- BNDNG: <Shift-Ctrl-Alt-A>
--   hs.hotkey.bind({"shift", "ctrl", "alt"}, "A", function()
--    local toggle = true
--
--     browserWindowFronters:browserWindowFrontOrOpen(
--       "https://mail.google.com/mail/u/0/#inbox",
--       "Profile 1",
--       {
--         "user2@gmail.com",
--       },
--       toggle
--     )
--   end)
--
--   -- Override Hammyspoony binding: Change "@gmail.com" -> "user1@gmail.com"
--   -- so that user2@gmail.com window not fronted on this binding (nor any
--   -- other Gmail account you have open).
--   --
--   -- BNDNG: <Shift-Ctrl-Cmd-A>
--   hs.hotkey.bind({"shift", "ctrl", "cmd"}, "A", function()
--    local toggle = true
--
--     browserWindowFronters:browserWindowFrontOrOpen(
--       "https://mail.google.com/mail/u/0/#inbox",
--       {
--         "user1@gmail.com",
--         "Google Calendar - ",
--         "Inbox ",
--         "Mail - ",
--         "Sign in to Outlook",
--         "Sign out",
--       },
--       toggle
--     )
--   end)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --


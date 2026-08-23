-- USAGE:
--   m4_shim \
--     "+8" "home/.kit/nvim/landonb/nvim-lazyb/lua/config/options-private.EVAL.lua" \
--     "home/.kit/nvim/landonb/nvim-lazyb/lua/config/options-private.lua"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- vim:tw=0:ts=2:sw=2:et:norl:nospell:ft=lua
-- DXY_HEADER_AUTHOR
-- DXY_HEADER_PROJECT
-- DXY_HEADER_LICENSE

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Use 11pt. font on GNU/Linux, vs. 12pt. on macOS/Darwin.
if vim.fn.has("gui_running") == 1 and vim.fn.has("linux") == 1 then
  vim.opt.guifont = "Hack Nerd Font,JoyPixels:h11:#e-subpixelantialias:#h-none"
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- CXREF:
--   nvim/landonb/nvim-lazyb/lua/plugins/embrace-vim.lua
--   nvim/landonb/vim-title-bar-time-of-day/autoload/embrace/titlebar.vim
vim.g.TitleBarTimeOfDayFriendlyNameRoot = "DXY_VENDOR_HOME_TILDE"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

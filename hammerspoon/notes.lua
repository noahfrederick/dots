--
-- Neovim notes
--
local editor = "VimR"
local delay = 1.0 -- Potentially wait for editor to start.
local leader = " "
local hyper = {"cmd", "alt", "ctrl", "shift"}
local keys = {"c", "n"}

for _, key in ipairs(keys) do
  hs.hotkey.bind(hyper, key, function()
    if hs.application.launchOrFocus(editor) then
      hs.timer.doAfter(delay, function()
        hs.eventtap.keyStrokes(leader..key)
      end)
    end
  end)
end

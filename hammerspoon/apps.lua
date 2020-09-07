--
-- App launching/focusing
--
local hyper = {"cmd", "alt", "ctrl", "shift"}
local apps = {
  Firefox = "b",
  DevDocs = "d",
  VimR = "e",
  Mail = "m",
  Alacritty = "t",
}

for app, key in pairs(apps) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

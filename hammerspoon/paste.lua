--
-- Simulate paste by typing
--
hs.hotkey.bind({"cmd", "alt"}, "v", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

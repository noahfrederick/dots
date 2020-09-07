require("apps")
require("notes")
require("paste")

hs.loadSpoon("ReloadConfiguration")

spoon.ReloadConfiguration:start()

hs.notify.new({title="Hammerspoon", informativeText="Configuration loaded"}):send()

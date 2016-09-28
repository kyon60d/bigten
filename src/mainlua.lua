
require "cocos.init"

require "network.protobuf"
require "lpeg"
require "bit32"
-- require "lpack"
setmetatable(_G,
    {
        __newindex = function(_,name,value)
            local msg = debug.traceback("DISABLE SET GLOBAL VARIABLE:"..name,1)
            print(msg)
        end
    }
)
local mmgr = require "module_manager"
mmgr.InitModule(require "module_config")
local myApp = mmgr.GetModule("MyApp")
local status,msg = xpcall(myApp.Run,myApp.TrackBack)
if not status then
    print(msg)
end


local lmA = {}
function lmA.GetModuleName()
    return "MyApp"
end

local lmB = {
    MainScene = "MainScene",
    Protoc = "Protoc"
}
function lmA.GetImportModule()
    return lmB
end

local lmC = {}

local bit32 = require "bit32"

function lmA.TrackBack(msg)
    local msg = debug.traceback(msg,3)
    print(msg)
    return msg
end

function lmA.Run()
    math.randomseed(os.time())

    local scene = cc.Scene:create()
    local director = cc.Director:getInstance()
    if director:getRunningScene() then
        director:replaceScene(scene)
    else
        director:runWithScene(scene)
    end
    local mainScene = lmB.MainScene.Create()
    scene:addChild(mainScene)

    -- lmA.CreateSock()
end

function lmA.Login()
    lmB.Protoc.Register({"login"})
    local data = lmB.Protoc.Encode("login_req", {passport = "win32_gt4"})

    lmA.SendData(1001,data)
    local mdate = lmB.Protoc.Encode("Msg", {type = "login_req",data = data})
    print("wwww",#data,#mdate)
    print(mdate)
end

function lmA.CreateSock()
    local address = "192.168.2.224:9102"
    lmC.wsSock = cc.WebSocket:create(address)
    local function wsOpen(...)
        print("wsOnOpen",...)
        lmA.Login()
    end
    local function wsClose(...)
        print("wsOnClose",...)
        lmC.wsSock = nil
    end
    local function wsError(...)
        print("wsOnError",...)
        lmC.wsSock:close()
        lmC.wsSock = nil
    end
    local function wsMessage(paramTable)
        local length = #paramTable
        if length < 4 then
            return
        end
        local msgid = paramTable[4]
        msgid = msgid + bit32.lshift(paramTable[1], 24)
        msgid = msgid + bit32.lshift(paramTable[2], 16)
        msgid = msgid + bit32.lshift(paramTable[3],  8)
        print("wsOnMessage",msgid)
        if msgid == 1002 then
            local strTable = {}
            local index = 1
            for i = 5,length do
                strTable[index] = string.char(paramTable[i])
                index = index + 1
            end
            local str = table.concat(strTable)
            local data = lmB.Protoc.Decode("login_resp",str)
            local sss = lmB.Protoc.Decode(data.playerTime[1],data.playerTime[2])
            for k,v in pairs(sss) do
                print(k,v)
                if type(v) == "number" then
                    print("number")
                elseif type(v) == "string" then
                    print("string")
                elseif type(v) == "table" then
                    for m,n in pairs(v) do
                        print(m,n)
                        if type(n) == "number" then
                            print("number")
                        elseif type(n) == "string" then
                            print("string")
                        elseif type(n) == "table" then
                            print("table")
                        end
                    end
                end
            end
        end
    end
    lmC.wsSock:registerScriptHandler(wsOpen,cc.WEBSOCKET_OPEN)
    lmC.wsSock:registerScriptHandler(wsMessage,cc.WEBSOCKET_MESSAGE)
    lmC.wsSock:registerScriptHandler(wsClose,cc.WEBSOCKET_CLOSE)
    lmC.wsSock:registerScriptHandler(wsError,cc.WEBSOCKET_ERROR) 
end

function lmA.SendData(msgid,data)
    if lmC.wsSock ~= nil and lmC.wsSock:getReadyState() == cc.WEBSOCKET_STATE_OPEN then
        local str = lmB.Protoc.GetMsgHeader(msgid)
        lmC.wsSock:sendString(str..data)
        print("ws msgid",msgid)
        return true
    else
        return false
    end
end

return lmA

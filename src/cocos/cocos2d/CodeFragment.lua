function printLog(tag, fmt, ...)
    local t = {
        "[",
        string.upper(tostring(tag)),
        "] ",
        string.format(tostring(fmt), ...)
    }
    print(table.concat(t))
end



-- export global variable
local __g = _G
cc.exports = {}
setmetatable(cc.exports, {
    __newindex = function(_, name, value)
        rawset(__g, name, value)
    end,
    __index = function(_, name)
        return rawget(__g, name)
    end
})
-- disable create unexpected global variable
function cc.disable_global()
    setmetatable(__g, {
        __newindex = function(_, name, value)
            error(string.format("USE \" cc.exports.%s = value \" INSTEAD OF SET GLOBAL VARIABLE", name), 0)
        end
    })
end
-- disable create unexpected global variable
cc.disable_global()



-- cc.DelayTime:create()
-- cc.Show:create()
-- cc.DelayTime:create()
-- cc.Animate:create()
-- cc.RemoveSelf:create()
-- cc.CallFunc:create()
-- cc.Sequence:create()
-- cc.RepeatForever:create()
-- MenuItem:registerScriptTapHandler

-- Node:scheduleUpdateWithPriorityLua
-- Node:registerScriptHandler:(function(state)
--     if state == "enter" then
--     elseif state == "exit" then
--     elseif state == "enterTransitionFinish" then
--     elseif state == "exitTransitionStart" then
--     elseif state == "cleanup" then
--     end
-- end)
-- Node:unregisterScriptHandler

-- Layer:unregisterScriptTouchHandler
-- function Layer:onTouch(callback, isMultiTouches, swallowTouches)
--     if type(isMultiTouches) ~= "boolean" then isMultiTouches = false end
--     if type(swallowTouches) ~= "boolean" then swallowTouches = false end

--     self:registerScriptTouchHandler(function(state, ...)
--         local args = {...}
--         local event = {name = state}
--         if isMultiTouches then
--             args = args[1]
--             local points = {}
--             for i = 1, #args, 3 do
--                 local x, y, id = args[i], args[i + 1], args[i + 2]
--                 points[id] = {x = x, y = y, id = id}
--             end
--             event.points = points
--         else
--             event.x = args[1]
--             event.y = args[2]
--         end
--         return callback( event )
--     end, isMultiTouches, 0, swallowTouches)
--     self:setTouchEnabled(true)
--     return self
-- end
-- Layer:registerScriptKeypadHandler()
-- Layer:setKeyboardEnabled()
-- Layer:unregisterScriptKeypadHandler()
-- Layer:registerScriptAccelerateHandler()
-- Layer:setAccelerometerEnabled()
-- Layer:unregisterScriptAccelerateHandler()

-- local engine = cc.SimpleAudioEngine:getInstance()
-- engine:getMusicVolume()
-- engine:setMusicVolume()
-- engine:preloadMusic()
-- engine:stopMusic()
-- engine:playMusic()
-- engine:pauseMusic()
-- engine:resumeMusic()
-- engine:rewindMusic()
-- engine:isMusicPlaying()
-- engine:getEffectsVolume()
-- engine:setEffectsVolume()
-- engine:playEffect()
-- engine:pauseEffect()
-- engine:pauseAllEffects()
-- engine:resumeEffect()
-- engine:resumeAllEffects()
-- engine:stopEffect()
-- engine:stopAllEffects()
-- engine:preloadEffect(filename)
-- engine:unloadEffect(filename)

-- local ACTION_EASING = {}
-- ACTION_EASING["BACKIN"]           = {cc.EaseBackIn, 1}
-- ACTION_EASING["BACKINOUT"]        = {cc.EaseBackInOut, 1}
-- ACTION_EASING["BACKOUT"]          = {cc.EaseBackOut, 1}
-- ACTION_EASING["BOUNCE"]           = {cc.EaseBounce, 1}
-- ACTION_EASING["BOUNCEIN"]         = {cc.EaseBounceIn, 1}
-- ACTION_EASING["BOUNCEINOUT"]      = {cc.EaseBounceInOut, 1}
-- ACTION_EASING["BOUNCEOUT"]        = {cc.EaseBounceOut, 1}
-- ACTION_EASING["ELASTIC"]          = {cc.EaseElastic, 2, 0.3}
-- ACTION_EASING["ELASTICIN"]        = {cc.EaseElasticIn, 2, 0.3}
-- ACTION_EASING["ELASTICINOUT"]     = {cc.EaseElasticInOut, 2, 0.3}
-- ACTION_EASING["ELASTICOUT"]       = {cc.EaseElasticOut, 2, 0.3}
-- ACTION_EASING["EXPONENTIALIN"]    = {cc.EaseExponentialIn, 1}
-- ACTION_EASING["EXPONENTIALINOUT"] = {cc.EaseExponentialInOut, 1}
-- ACTION_EASING["EXPONENTIALOUT"]   = {cc.EaseExponentialOut, 1}
-- ACTION_EASING["IN"]               = {cc.EaseIn, 2, 1}
-- ACTION_EASING["INOUT"]            = {cc.EaseInOut, 2, 1}
-- ACTION_EASING["OUT"]              = {cc.EaseOut, 2, 1}
-- ACTION_EASING["RATEACTION"]       = {cc.EaseRateAction, 2, 1}
-- ACTION_EASING["SINEIN"]           = {cc.EaseSineIn, 1}
-- ACTION_EASING["SINEINOUT"]        = {cc.EaseSineInOut, 1}
-- ACTION_EASING["SINEOUT"]          = {cc.EaseSineOut, 1}

-- view = cc.GLViewImpl:createWithRect("", cc.rect(0, 0, width, height))
-- director:setOpenGLView(view)
-- cc.FileUtils:getInstance():getWritablePath()
-- display.directorySeparator = "/"
-- display.pathSeparator = ":"
-- if display.platform == cc.PLATFORM_OS_WINDOWS then
--     display.directorySeparator = "\\"
--     display.pathSeparator = ";"
-- end

-- cc.Scene:create()
-- cc.Scene:createWithPhysics()
-- director:getRunningScene()
-- director:runWithScene()
-- director:replaceScene()

-- cc.Layer:create()
-- cc.convertColor(color, "4b")
-- cc.LayerColor:create(color)
-- cc.LayerColor:create(color,width,height)
-- cc.LayerGradient:create(color1,color2)

-- cc.Sprite
-- ccui.Scale9Sprite
-- createWithSpriteFrameName
-- createWithSpriteFrame
-- createWithTexture
-- cc.Texture2D:setDefaultAlphaPixelFormat()

-- local textureCache = director:getTextureCache()
-- local spriteFrameCache = cc.SpriteFrameCache:getInstance()
-- local animationCache = cc.AnimationCache:getInstance()

-- spriteFrameCache:getSpriteFrame
-- spriteFrameCache:addSpriteFrames
-- spriteFrameCache:addSpriteFramesAsync
-- spriteFrameCache:removeSpriteFrameByName
-- spriteFrameCache:removeSpriteFramesFromFile

-- textureCache:removeTextureForKey
-- textureCache:getTextureForKey
-- textureCache:addImage
-- textureCache:addImageAsync
-- local path = cc.FileUtils:getInstance():fullPathForFilename(name)
-- return textureCache:getTextureForKey(path)

-- spriteFrameCache:removeUnusedSpriteFrames()
-- textureCache:removeUnusedTextures()

-- cc.Animation:createWithSpriteFrames
-- animationCache:addAnimation
-- animationCache:getAnimation
-- animationCache:removeAnimation

display.SCENE_TRANSITIONS = {
    CROSSFADE       = {cc.TransitionCrossFade},
    FADE            = {cc.TransitionFade, cc.c3b(0, 0, 0)},
    FADEBL          = {cc.TransitionFadeBL},
    FADEDOWN        = {cc.TransitionFadeDown},
    FADETR          = {cc.TransitionFadeTR},
    FADEUP          = {cc.TransitionFadeUp},
    FLIPANGULAR     = {cc.TransitionFlipAngular, cc.TRANSITION_ORIENTATION_LEFT_OVER},
    FLIPX           = {cc.TransitionFlipX, cc.TRANSITION_ORIENTATION_LEFT_OVER},
    FLIPY           = {cc.TransitionFlipY, cc.TRANSITION_ORIENTATION_UP_OVER},
    JUMPZOOM        = {cc.TransitionJumpZoom},
    MOVEINB         = {cc.TransitionMoveInB},
    MOVEINL         = {cc.TransitionMoveInL},
    MOVEINR         = {cc.TransitionMoveInR},
    MOVEINT         = {cc.TransitionMoveInT},
    PAGETURN        = {cc.TransitionPageTurn, false},
    ROTOZOOM        = {cc.TransitionRotoZoom},
    SHRINKGROW      = {cc.TransitionShrinkGrow},
    SLIDEINB        = {cc.TransitionSlideInB},
    SLIDEINL        = {cc.TransitionSlideInL},
    SLIDEINR        = {cc.TransitionSlideInR},
    SLIDEINT        = {cc.TransitionSlideInT},
    SPLITCOLS       = {cc.TransitionSplitCols},
    SPLITROWS       = {cc.TransitionSplitRows},
    TURNOFFTILES    = {cc.TransitionTurnOffTiles},
    ZOOMFLIPANGULAR = {cc.TransitionZoomFlipAngular},
    ZOOMFLIPX       = {cc.TransitionZoomFlipX, cc.TRANSITION_ORIENTATION_LEFT_OVER},
    ZOOMFLIPY       = {cc.TransitionZoomFlipY, cc.TRANSITION_ORIENTATION_UP_OVER},
}

local node = {}

-- priority越小越先调用
-- 先调用函数会先调用
local priority = 0
local function fuc(dt)
end
function node:scheduleUpdateWithPriorityLua(fuc,priority)
end

registerScriptHandler

io.read()

function GuideNewMgr:showDecorate()
    NetworkManager:Instance():sendRequestMessage(ProtocolId.otherPlayerHouseInfo_req,
        {playerid = 1020000330, type = 1},
        function(msg)
            if GCheckMsgSuccess(msg) then
                local otherInfo = {}
                otherInfo.playerid = 1020000330
                otherInfo.roomEvent = msg.roomEvent
                otherInfo.maxFloor = msg.maxFloor
                Decorate:setOtherRoomInfo(otherInfo)
                NetworkManager:Instance():sendRequestMessage(ProtocolId.otherPlayerHouseInfo_req,
                    {playerid = 1020000330, type = 2, floor = 1},
                    function(msg)
                        if GCheckMsgSuccess(msg) then
                            Decorate:setOtherRoomDetail(msg.roomInfo,1)
                            app:enterDecorateScene({myhome = false,floor = 1})
                        else
                            Toast.ShowErrorCode(GGetErrorId(msg))
                        end
                    end)
            else
                Toast.ShowErrorCode(GGetErrorId(msg))
            end
        end)
end

if 24024 == tonumber(protocolid) then
    table.insert(ppp,pb_data)
    if #ppp == 2 then
        local file = io.open("F:\\qwe.json","w+")
        file:write(json.encode(ppp))
        file:close()
    end
end

Company.HomeInstance:showLogicWaitLayer()
local id = ccexp.AudioEngine:play2d(file,false,1.0)
ccexp.AudioEngine:setFinishCallback(id,function()
    Company.HomeInstance:hideLogicWaitLayer()
end)


local param = {
    stageId = level,
    cardid = {1101},
    win = 1,
    star = 3,
    vote = 0
}
level = level + 1
NetworkManager:Instance():sendRequestMessage(ProtocolId.challengeResult_req, param,
function(msg)
    if(GCheckMsgSuccess(msg)) then
    else
    end
end)

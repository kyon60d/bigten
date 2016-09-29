
local lmA = {}
function lmA.GetModuleName()
    return "MainScene"
end

function lmA.Create()
    local self = cc.Layer:create()
    -- add background image
    local sprite = cc.Sprite:create("123.jpg")
    sprite:setPosition(display.cx,display.cy)
    sprite:setAnchorPoint(0.5,0.5)
    self:addChild(sprite)

    local label = cc.Label:createWithTTF("Hello World","fzcy.ttf",30)
    label:setPosition(display.cx, display.cy + 200)
    label:setColor(cc.c3b(0,0,0))
    self:addChild(label)

    local sp = cc.Sprite:create("1101_1.png")
    sp:setPosition(display.cx, display.cy)
    self:addChild(sp)

    sp:runAction(cc.FadeOut:create(3))

    local vsl = "shader/vs.vert"
    local fsl = "shader/fs_c.frag"
    local shader = cc.GLProgram:createWithFilenames(vsl,fsl)
    local state = cc.GLProgramState:create(shader)
    sp:setGLProgramState(state)

    -- local alf = 1.0
    -- self:scheduleUpdateWithPriorityLua(function()
    --     alf = alf - 0.01
    --     if alf < 0.01 then
    --         alf = 1.0
    --     end
    --     state:setUniformFloat("a_alf",alf)
    -- end,0)
    return self
end

return lmA

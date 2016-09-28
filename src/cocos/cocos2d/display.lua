
local display = {}

local app = cc.Application:getInstance()
display.language = app:getCurrentLanguage() or cc.LANGUAGE_ENGLISH
display.platform = app:getTargetPlatform() or cc.PLATFORM_OS_WINDOWS

local director = cc.Director:getInstance()
local view = director:getOpenGLView()
local sizeInPixels = view:getFrameSize()

-- 按1024*576排列
display.width = 1024
display.height = display.width*sizeInPixels.height/sizeInPixels.width
if display.height > 768 then
	-- 拉伸高度，填满屏幕 或留黑边
	display.height = 768
elseif display.height < 576 then
	-- 压缩高度，缩到屏幕
	display.height = 576
else
	-- 576-768 根据高度适当更改节点的y坐标
end
display.cx = display.width*0.5
display.cy = display.height*0.5

display.scale = 1
if sizeInPixels.width < 1024 then
	-- 小于1024时 缩放根节点
	display.scale = sizeInPixels.width/1024
end

local width = display.width*display.scale
local height = display.height*display.scale

local rp = cc.ResolutionPolicy.EXACT_FIT
rp = cc.ResolutionPolicy.SHOW_ALL
view:setDesignResolutionSize(width,height,rp)

return display

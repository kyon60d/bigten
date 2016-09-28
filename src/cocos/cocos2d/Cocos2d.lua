
cc = cc or {}

function cc.schedule(node, callback, delay)
    local delay = cc.DelayTime:create(delay)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    local action = cc.RepeatForever:create(sequence)
    node:runAction(action)
    return action
end

function cc.performWithDelay(node, callback, delay)
    local delay = cc.DelayTime:create(delay)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    node:runAction(sequence)
    return sequence
end


function cc.clampf(value, min_inclusive, max_inclusive)
    -- body
    local temp = 0
    if min_inclusive > max_inclusive then
        temp = min_inclusive
        min_inclusive =  max_inclusive
        max_inclusive = temp
    end

    if value < min_inclusive then
        return min_inclusive
    elseif value < max_inclusive then
        return value
    else
        return max_inclusive
    end
end

--Point
function cc.p(_x,_y)
    if nil == _y then
         return { x = _x.x, y = _x.y }
    else
         return { x = _x, y = _y }
    end
end

function cc.pAdd(pt1,pt2)
    return {x = pt1.x + pt2.x , y = pt1.y + pt2.y }
end

function cc.pSub(pt1,pt2)
    return {x = pt1.x - pt2.x , y = pt1.y - pt2.y }
end

function cc.pMul(pt1,factor)
    return { x = pt1.x * factor , y = pt1.y * factor }
end

function cc.pMidpoint(pt1,pt2)
    return { x = (pt1.x + pt2.x) / 2.0 , y = ( pt1.y + pt2.y) / 2.0 }
end

function cc.pForAngle(a)
    return { x = math.cos(a), y = math.sin(a) }
end

function cc.pGetLength(pt)
    return math.sqrt( pt.x * pt.x + pt.y * pt.y )
end

function cc.pNormalize(pt)
    local length = cc.pGetLength(pt)
    if 0 == length then
        return { x = 1.0,y = 0.0 }
    end

    return { x = pt.x / length, y = pt.y / length }
end

function cc.pCross(self,other)
    return self.x * other.y - self.y * other.x
end

function cc.pDot(self,other)
    return self.x * other.x + self.y * other.y
end

function cc.pToAngleSelf(self)
    return math.atan2(self.y, self.x)
end

function cc.pGetAngle(self,other)
    local a2 = cc.pNormalize(self)
    local b2 = cc.pNormalize(other)
    local angle = math.atan2(cc.pCross(a2, b2), cc.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end

    return angle
end

function cc.pGetDistance(startP,endP)
    return cc.pGetLength(cc.pSub(startP,endP))
end

function cc.pIsLineIntersect(A, B, C, D, s, t)
    if ((A.x == B.x) and (A.y == B.y)) or ((C.x == D.x) and (C.y == D.y))then
        return false, s, t
    end

    local BAx = B.x - A.x
    local BAy = B.y - A.y
    local DCx = D.x - C.x
    local DCy = D.y - C.y
    local ACx = A.x - C.x
    local ACy = A.y - C.y

    local denom = DCy * BAx - DCx * BAy
    s = DCx * ACy - DCy * ACx
    t = BAx * ACy - BAy * ACx

    if (denom == 0) then
        if (s == 0 or t == 0) then
            return true, s , t
        end

        return false, s, t
    end

    s = s / denom
    t = t / denom

    return true,s,t
end

function cc.pPerp(pt)
    return { x = -pt.y, y = pt.x }
end

function cc.RPerp(pt)
    return { x = pt.y,  y = -pt.x }
end

function cc.pProject(pt1, pt2)
    return { x = pt2.x * (cc.pDot(pt1,pt2) / cc.pDot(pt2,pt2)) , y = pt2.y * (cc.pDot(pt1,pt2) / cc.pDot(pt2,pt2)) }
end

function cc.pRotate(pt1, pt2)
    return { x = pt1.x * pt2.x - pt1.y * pt2.y, y = pt1.x * pt2.y + pt1.y * pt2.x }
end

function cc.pUnrotate(pt1, pt2)
    return { x = pt1.x * pt2.x + pt1.y * pt2.y, pt1.y * pt2.x - pt1.x * pt2.y }
end
--Calculates the square length of pt
function cc.pLengthSQ(pt)
    return cc.pDot(pt,pt)
end
--Calculates the square distance between pt1 and pt2
function cc.pDistanceSQ(pt1,pt2)
    return cc.pLengthSQ(cc.pSub(pt1,pt2))
end

function cc.pGetClampPoint(pt1,pt2,pt3)
    return { x = cc.clampf(pt1.x, pt2.x, pt3.x), y = cc.clampf(pt1.y, pt2.y, pt3.y) }
end

function cc.pFromSize(sz)
    return { x = sz.width, y = sz.height }
end

function cc.pLerp(pt1,pt2,alpha)
    return cc.pAdd(cc.pMul(pt1, 1.0 - alpha), cc.pMul(pt2,alpha) )
end

function cc.pFuzzyEqual(pt1,pt2,variance)
    if (pt1.x - variance <= pt2.x) and (pt2.x <= pt1.x + variance) and (pt1.y - variance <= pt2.y) and (pt2.y <= pt1.y + variance) then
        return true
    else
        return false
    end
end

function cc.pRotateByAngle(pt1, pt2, angle)
    return cc.pAdd(pt2, cc.pRotate( cc.pSub(pt1, pt2),cc.pForAngle(angle)))
end

function cc.pIsSegmentIntersect(pt1,pt2,pt3,pt4)
    local s,t,ret = 0,0,false
    ret,s,t =cc.pIsLineIntersect(pt1, pt2, pt3, pt4,s,t)

    if ret and  s >= 0.0 and s <= 1.0 and t >= 0.0 and t <= 1.0 then
        return true
    end

    return false
end

function cc.pGetIntersectPoint(pt1,pt2,pt3,pt4)
    local s,t, ret = 0,0,false
    ret,s,t = cc.pIsLineIntersect(pt1,pt2,pt3,pt4,s,t)
    if ret then
        return cc.p(pt1.x + s * (pt2.x - pt1.x), pt1.y + s * (pt2.y - pt1.y))
    else
        return cc.p(0,0)
    end
end
--Size
function cc.size( _width,_height )
    return { width = _width, height = _height }
end

--Rect
function cc.rect(_x,_y,_width,_height)
    return { x = _x, y = _y, width = _width, height = _height }
end

function cc.rectEqualToRect(rect1,rect2)
    if ((rect1.x >= rect2.x) or (rect1.y >= rect2.y) or
        ( rect1.x + rect1.width <= rect2.x + rect2.width) or
        ( rect1.y + rect1.height <= rect2.y + rect2.height)) then
        return false
    end

    return true
end

function cc.rectGetMaxX(rect)
    return rect.x + rect.width
end

function cc.rectGetMidX(rect)
    return rect.x + rect.width / 2.0
end

function cc.rectGetMinX(rect)
    return rect.x
end

function cc.rectGetMaxY(rect)
    return rect.y + rect.height
end

function cc.rectGetMidY(rect)
    return rect.y + rect.height / 2.0
end

function cc.rectGetMinY(rect)
    return rect.y
end

function cc.rectContainsPoint( rect, point )
    local ret = false

    if (point.x >= rect.x) and (point.x <= rect.x + rect.width) and
       (point.y >= rect.y) and (point.y <= rect.y + rect.height) then
        ret = true
    end

    return ret
end

function cc.rectIntersectsRect( rect1, rect2 )
    local intersect = not ( rect1.x > rect2.x + rect2.width or
                    rect1.x + rect1.width < rect2.x         or
                    rect1.y > rect2.y + rect2.height        or
                    rect1.y + rect1.height < rect2.y )

    return intersect
end

function cc.rectUnion( rect1, rect2 )
    local rect = cc.rect(0, 0, 0, 0)
    rect.x = math.min(rect1.x, rect2.x)
    rect.y = math.min(rect1.y, rect2.y)
    rect.width = math.max(rect1.x + rect1.width, rect2.x + rect2.width) - rect.x
    rect.height = math.max(rect1.y + rect1.height, rect2.y + rect2.height) - rect.y
    return rect
end

function cc.rectIntersection( rect1, rect2 )
    local intersection = cc.rect(
        math.max(rect1.x, rect2.x),
        math.max(rect1.y, rect2.y),
        0, 0)

    intersection.width = math.min(rect1.x + rect1.width, rect2.x + rect2.width) - intersection.x
    intersection.height = math.min(rect1.y + rect1.height, rect2.y + rect2.height) - intersection.y
    return intersection
end

--Color3B
function cc.c3b( _r,_g,_b )
    return { r = _r, g = _g, b = _b }
end

--Color4B
function cc.c4b( _r,_g,_b,_a )
    return { r = _r, g = _g, b = _b, a = _a }
end

--Color4F
function cc.c4f( _r,_g,_b,_a )
    return { r = _r, g = _g, b = _b, a = _a }
end

local function isFloatColor(c)
    return (c.r <= 1 and c.g <= 1 and c.b <= 1) and (math.ceil(c.r) ~= c.r or math.ceil(c.g) ~= c.g or math.ceil(c.b) ~= c.b)
end

function cc.convertColor(input, typ)
    assert(type(input) == "table" and input.r and input.g and input.b, "cc.convertColor() - invalid input color")
    local ret
    if typ == "3b" then
        if isFloatColor(input) then
            ret = {r = math.ceil(input.r * 255), g = math.ceil(input.g * 255), b = math.ceil(input.b * 255)}
        else
            ret = {r = input.r, g = input.g, b = input.b}
        end
    elseif typ == "4b" then
        if isFloatColor(input) then
            ret = {r = math.ceil(input.r * 255), g = math.ceil(input.g * 255), b = math.ceil(input.b * 255)}
        else
            ret = {r = input.r, g = input.g, b = input.b}
        end
        if input.a then
            if math.ceil(input.a) ~= input.a or input.a >= 1 then
                ret.a = input.a * 255
            else
                ret.a = input.a
            end
        else
            ret.a = 255
        end
    elseif typ == "4f" then
        if isFloatColor(input) then
            ret = {r = input.r, g = input.g, b = input.b}
        else
            ret = {r = input.r / 255, g = input.g / 255, b = input.b / 255}
        end
        if input.a then
            if math.ceil(input.a) ~= input.a or input.a >= 1 then
                ret.a = input.a
            else
                ret.a = input.a / 255
            end
        else
            ret.a = 255
        end
    else
        error(string.format("cc.convertColor() - invalid type %s", typ), 0)
    end
    return ret
end

--Vertex2F
function cc.vertex2F(_x,_y)
    return { x = _x, y = _y }
end

--Vertex3F
function cc.Vertex3F(_x,_y,_z)
    return { x = _x, y = _y, z = _z }
end

--Tex2F
function cc.tex2F(_u,_v)
    return { u = _u, v = _v }
end

--PointSprite
function cc.PointSprite(_pos,_color,_size)
    return { pos = _pos, color = _color, size = _size }
end

--Quad2
function cc.Quad2(_tl,_tr,_bl,_br)
    return { tl = _tl, tr = _tr, bl = _bl, br = _br }
end

--Quad3
function cc.Quad3(_tl, _tr, _bl, _br)
    return { tl = _tl, tr = _tr, bl = _bl, br = _br }
end

--V2F_C4B_T2F
function cc.V2F_C4B_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V2F_C4F_T2F
function cc.V2F_C4F_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V3F_C4B_T2F
function cc.V3F_C4B_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V2F_C4B_T2F_Quad
function cc.V2F_C4B_T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--V3F_C4B_T2F_Quad
function cc.V3F_C4B_T2F_Quad(_tl, _bl, _tr, _br)
    return { tl = _tl, bl = _bl, tr = _tr, br = _br }
end

--V2F_C4F_T2F_Quad
function cc.V2F_C4F_T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--T2F_Quad
function cc.T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--AnimationFrameData
function cc.AnimationFrameData( _texCoords, _delay, _size)
    return { texCoords = _texCoords, delay = _delay, size = _size }
end

--PhysicsMaterial
function cc.PhysicsMaterial(_density, _restitution, _friction)
    return { density = _density, restitution = _restitution, friction = _friction }
end

function cc.vec3(_x, _y, _z)
    return { x = _x, y = _y, z = _z }
end

function cc.vec4(_x, _y, _z, _w)
    return { x = _x, y = _y, z = _z, w = _w }
end

function cc.vec3normalize(vec3)
    local n = vec3.x * vec3.x + vec3.y * vec3.y + vec3.z * vec3.z
    if n == 1.0 then
        return vec3
    end

    n = math.sqrt(n)

    if n < 2e-37 then
        return vec3
    end

    n = 1.0 / n
    return {x = vec3.x * n, y = vec3.y * n, z = vec3.z * n}
end

function cc.quaternion(_x, _y ,_z,_w)
    return { x = _x, y = _y, z = _z, w = _w }
end

function cc.quaternion_createFromAxisAngle(axis, angle)

    local  halfAngle = angle * 0.5
    local  sinHalfAngle = math.sin(halfAngle)

    local normal = cc.vec3(axis.x, axis.y, axis.z)
    normal = cc.vec3normalize(normal)
    local dst = cc.vec3(0.0, 0.0, 0.0)
    dst.x = normal.x * sinHalfAngle
    dst.y = normal.y * sinHalfAngle
    dst.z = normal.z * sinHalfAngle
    dst.w = math.cos(halfAngle)

    return dst
end

function cc.blendFunc(_src, _dst)
    return {src = _src, dst = _dst}
end

cc.mat4 = cc.mat4 or {}

function cc.mat4.new(...)
    local params = {...}
    local size   = #params
    local obj = {}

    if 1 == size then
        assert(type(params[1]) == "table" , "type of input params are wrong to new a mat4 when num of params is 1")
        for i= 1, 16 do
            if params[1][i] ~= nil then
                obj[i] = params[1][i]
            else
                obj[i] = 0
            end
        end
    elseif 16 == size then
        for i= 1, 16 do
            obj[i] = params[i]
        end
    end

    setmetatable(obj, {__index = cc.mat4})

    return obj
end

function cc.mat4.getInversed(self)
    return mat4_getInversed(self)
end

function cc.mat4.transformVector(self, vector, dst)
    return mat4_transformVector(self, vector, dst)
end

function cc.mat4.multiply(self, mat)
    return mat4_multiply(self, mat)
end

function cc.mat4.decompose(self, scale, rotation, translation)
    return mat4_decompose(self, scale ,rotation, translation)
end

function cc.mat4.createIdentity()
    return cc.mat4.new(1.0 ,0.0, 0.0, 0.0,
                       0.0, 1.0, 0.0, 0.0,
                       0.0, 0.0, 1.0, 0.0,
                       0.0, 0.0, 0.0, 1.0)
end

function cc.mat4.createTranslation(translation, dst)
    assert(type(translation) == "table" and type(dst) == "table", "The type of input parameters should be table")
    dst = cc.mat4.createIdentity()
    dst[13] = translation.x
    dst[14] = translation.y
    dst[15] = translation.z
    return dst
end

function cc.mat4.createRotation(q, dst)
    assert(type(q) == "table" and type(dst) == "table", "The type of input parameters should be table")
    local x2 = q.x + q.x
    local y2 = q.y + q.y
    local z2 = q.z + q.z

    local xx2 = q.x * x2
    local yy2 = q.y * y2
    local zz2 = q.z * z2
    local xy2 = q.x * y2
    local xz2 = q.x * z2
    local yz2 = q.y * z2
    local wx2 = q.w * x2
    local wy2 = q.w * y2
    local wz2 = q.w * z2

    dst[1] = 1.0 - yy2 - zz2
    dst[2] = xy2 + wz2
    dst[3] = xz2 - wy2
    dst[4] = 0.0

    dst[5] = xy2 - wz2
    dst[6] = 1.0 - xx2 - zz2
    dst[7] = yz2 + wx2
    dst[8] = 0.0

    dst[9] = xz2 + wy2
    dst[10] = yz2 - wx2
    dst[11] = 1.0 - xx2 - yy2
    dst[12] = 0.0

    dst[13] = 0.0
    dst[14] = 0.0
    dst[15] = 0.0
    dst[16] = 1.0

    return dst
end

function cc.mat4.translate(self,vec3)
    return mat4_translate(self,vec3)
end

function cc.mat4.createRotationZ(self,angle)
    return mat4_createRotationZ(self,angle)
end

function cc.mat4.setIdentity(self)
    return mat4_setIdentity(self)
end

function cc.mat4.createTranslation(...)
    return mat4_createTranslation(...)
end

function cc.mat4.createRotation(...)
    return mat4_createRotation(...)
end

cc.SPRITE_INDEX_NOT_INITIALIZED = 0xffffffff
cc.TMX_ORIENTATION_HEX  = 0x1
cc.TMX_ORIENTATION_ISO  = 0x2
cc.TMX_ORIENTATION_ORTHO    = 0x0
cc.Z_COMPRESSION_BZIP2  = 0x1
cc.Z_COMPRESSION_GZIP   = 0x2
cc.Z_COMPRESSION_NONE   = 0x3
cc.Z_COMPRESSION_ZLIB   = 0x0
cc.BLEND_DST    = 0x303
cc.BLEND_SRC    = 0x1
cc.DIRECTOR_IOS_USE_BACKGROUND_THREAD   = 0x0
cc.DIRECTOR_MAC_THREAD  = 0x0
cc.DIRECTOR_STATS_INTERVAL  = 0.1
cc.ENABLE_BOX2_D_INTEGRATION    = 0x0
cc.ENABLE_DEPRECATED    = 0x1
cc.ENABLE_GL_STATE_CACHE    = 0x1
cc.ENABLE_PROFILERS = 0x0
cc.ENABLE_STACKABLE_ACTIONS = 0x1
cc.FIX_ARTIFACTS_BY_STRECHING_TEXEL = 0x0
cc.GL_ALL   = 0x0
cc.LABELATLAS_DEBUG_DRAW    = 0x0
cc.LABELBMFONT_DEBUG_DRAW   = 0x0
cc.MAC_USE_DISPLAY_LINK_THREAD  = 0x0
cc.MAC_USE_MAIN_THREAD  = 0x2
cc.MAC_USE_OWN_THREAD   = 0x1
cc.NODE_RENDER_SUBPIXEL = 0x1
cc.PVRMIPMAP_MAX    = 0x10
cc.SPRITEBATCHNODE_RENDER_SUBPIXEL  = 0x1
cc.SPRITE_DEBUG_DRAW    = 0x0
cc.TEXTURE_ATLAS_USE_TRIANGLE_STRIP = 0x0
cc.TEXTURE_ATLAS_USE_VAO    = 0x1
cc.USE_L_A88_LABELS = 0x1
cc.ACTION_TAG_INVALID   = -1
cc.DEVICE_MAC   = 0x6
cc.DEVICE_MAC_RETINA_DISPLAY    = 0x7
cc.DEVICEI_PAD  = 0x4
cc.DEVICEI_PAD_RETINA_DISPLAY   = 0x5
cc.DEVICEI_PHONE    = 0x0
cc.DEVICEI_PHONE5   = 0x2
cc.DEVICEI_PHONE5_RETINA_DISPLAY    = 0x3
cc.DEVICEI_PHONE_RETINA_DISPLAY = 0x1
cc.DIRECTOR_PROJECTION2_D   = 0x0
cc.DIRECTOR_PROJECTION3_D   = 0x1
cc.DIRECTOR_PROJECTION_CUSTOM   = 0x2
cc.DIRECTOR_PROJECTION_DEFAULT  = 0x1
cc.FILE_UTILS_SEARCH_DIRECTORY_MODE = 0x1
cc.FILE_UTILS_SEARCH_SUFFIX_MODE    = 0x0
cc.FLIPED_ALL   = 0xe0000000
cc.FLIPPED_MASK = 0x1fffffff
cc.IMAGE_FORMAT_JPEG    = 0x0
cc.IMAGE_FORMAT_PNG = 0x1
cc.ITEM_SIZE    = 0x20
cc.LABEL_AUTOMATIC_WIDTH    = -1
cc.LINE_BREAK_MODE_CHARACTER_WRAP   = 0x1
cc.LINE_BREAK_MODE_CLIP = 0x2
cc.LINE_BREAK_MODE_HEAD_TRUNCATION  = 0x3
cc.LINE_BREAK_MODE_MIDDLE_TRUNCATION    = 0x5
cc.LINE_BREAK_MODE_TAIL_TRUNCATION  = 0x4
cc.LINE_BREAK_MODE_WORD_WRAP    = 0x0
cc.MAC_VERSION_10_6 = 0xa060000
cc.MAC_VERSION_10_7 = 0xa070000
cc.MAC_VERSION_10_8 = 0xa080000
cc.MENU_HANDLER_PRIORITY    = -128
cc.MENU_STATE_TRACKING_TOUCH    = 0x1
cc.MENU_STATE_WAITING   = 0x0
cc.NODE_TAG_INVALID = -1
cc.PARTICLE_DURATION_INFINITY   = -1
cc.PARTICLE_MODE_GRAVITY    = 0x0
cc.PARTICLE_MODE_RADIUS = 0x1
cc.PARTICLE_START_RADIUS_EQUAL_TO_END_RADIUS    = -1
cc.PARTICLE_START_SIZE_EQUAL_TO_END_SIZE    = -1
cc.POSITION_TYPE_FREE   = 0x0
cc.POSITION_TYPE_GROUPED    = 0x2
cc.POSITION_TYPE_RELATIVE   = 0x1
cc.PRIORITY_NON_SYSTEM_MIN  = -2147483647
cc.PRIORITY_SYSTEM  = -2147483648
cc.PROGRESS_TIMER_TYPE_BAR  = 0x1
cc.PROGRESS_TIMER_TYPE_RADIAL   = 0x0
cc.REPEAT_FOREVER   = 0xfffffffe
cc.RESOLUTION_MAC   = 0x1
cc.RESOLUTION_MAC_RETINA_DISPLAY    = 0x2
cc.RESOLUTION_UNKNOWN   = 0x0
cc.TMX_TILE_DIAGONAL_FLAG   = 0x20000000
cc.TMX_TILE_HORIZONTAL_FLAG = 0x80000000
cc.TMX_TILE_VERTICAL_FLAG   = 0x40000000
cc.TEXT_ALIGNMENT_CENTER    = 0x1
cc.TEXT_ALIGNMENT_LEFT  = 0x0
cc.TEXT_ALIGNMENT_RIGHT = 0x2

cc.TEXTURE2_D_PIXEL_FORMAT_AUTO = 0x0
cc.TEXTURE2_D_PIXEL_FORMAT_BGR_A8888 = 0x1
cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888 = 0x2
cc.TEXTURE2_D_PIXEL_FORMAT_RG_B888    = 0x3
cc.TEXTURE2_D_PIXEL_FORMAT_RG_B565   = 0x4
cc.TEXTURE2_D_PIXEL_FORMAT_A8        = 0x5
cc.TEXTURE2_D_PIXEL_FORMAT_I8        = 0x6
cc.TEXTURE2_D_PIXEL_FORMAT_A_I88     = 0x7
cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A4444     = 0x8
cc.TEXTURE2_D_PIXEL_FORMAT_RGB5_A1       = 0x9
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC4        = 0xa
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC4A       = 0xb
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC2        = 0xc
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC2A       = 0xd
cc.TEXTURE2_D_PIXEL_FORMAT_ETC           = 0xe
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT1     = 0xf
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT3     = 0x10
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT5     = 0x11
cc.TEXTURE2_D_PIXEL_FORMAT_DEFAULT       = 0x0
cc.TOUCHES_ALL_AT_ONCE  = 0x0
cc.TOUCHES_ONE_BY_ONE   = 0x1
cc.TRANSITION_ORIENTATION_DOWN_OVER = 0x1
cc.TRANSITION_ORIENTATION_LEFT_OVER = 0x0
cc.TRANSITION_ORIENTATION_RIGHT_OVER    = 0x1
cc.TRANSITION_ORIENTATION_UP_OVER   = 0x0
cc.UNIFORM_COS_TIME = 0x5
cc.UNIFORM_MV_MATRIX    = 0x1
cc.UNIFORM_MVP_MATRIX   = 0x2
cc.UNIFORM_P_MATRIX = 0x0
cc.UNIFORM_RANDOM01 = 0x6
cc.UNIFORM_SAMPLER  = 0x7
cc.UNIFORM_SIN_TIME = 0x4
cc.UNIFORM_TIME = 0x3
cc.UNIFORM_MAX  = 0x8
cc.VERTEX_ATTRIB_FLAG_COLOR = 0x2
cc.VERTEX_ATTRIB_FLAG_NONE  = 0x0
cc.VERTEX_ATTRIB_FLAG_POS_COLOR_TEX = 0x7
cc.VERTEX_ATTRIB_FLAG_POSITION  = 0x1
cc.VERTEX_ATTRIB_FLAG_TEX_COORDS    = 0x4
cc.VERTEX_ATTRIB_COLOR  = 0x1
cc.VERTEX_ATTRIB_MAX    = 0x3
cc.VERTEX_ATTRIB_POSITION   = 0x0
cc.VERTEX_ATTRIB_TEX_COORD = 0x2

cc.VERTEX_ATTRIB_TEX_COORDS = 0x2
cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM   = 0x2
cc.VERTICAL_TEXT_ALIGNMENT_CENTER   = 0x1
cc.VERTICAL_TEXT_ALIGNMENT_TOP  = 0x0
cc.OS_VERSION_4_0   = 0x4000000
cc.OS_VERSION_4_0_1 = 0x4000100
cc.OS_VERSION_4_1   = 0x4010000
cc.OS_VERSION_4_2   = 0x4020000
cc.OS_VERSION_4_2_1 = 0x4020100
cc.OS_VERSION_4_3   = 0x4030000
cc.OS_VERSION_4_3_1 = 0x4030100
cc.OS_VERSION_4_3_2 = 0x4030200
cc.OS_VERSION_4_3_3 = 0x4030300
cc.OS_VERSION_4_3_4 = 0x4030400
cc.OS_VERSION_4_3_5 = 0x4030500
cc.OS_VERSION_5_0   = 0x5000000
cc.OS_VERSION_5_0_1 = 0x5000100
cc.OS_VERSION_5_1_0 = 0x5010000
cc.OS_VERSION_6_0_0 = 0x6000000
cc.ANIMATION_FRAME_DISPLAYED_NOTIFICATION   = 'CCAnimationFrameDisplayedNotification'
cc.CHIPMUNK_IMPORT  = 'chipmunk.h'
cc.ATTRIBUTE_NAME_COLOR = 'a_color'
cc.ATTRIBUTE_NAME_POSITION  = 'a_position'
cc.ATTRIBUTE_NAME_TEX_COORD = 'a_texCoord'
cc.SHADER_POSITION_COLOR    = 'ShaderPositionColor'
cc.SHADER_POSITION_LENGTH_TEXURE_COLOR  = 'ShaderPositionLengthTextureColor'
cc.SHADER_POSITION_TEXTURE  = 'ShaderPositionTexture'
cc.SHADER_POSITION_TEXTURE_A8_COLOR = 'ShaderPositionTextureA8Color'
cc.SHADER_POSITION_TEXTURE_COLOR    = 'ShaderPositionTextureColor'
cc.SHADER_POSITION_TEXTURE_COLOR_ALPHA_TEST = 'ShaderPositionTextureColorAlphaTest'
cc.SHADER_POSITION_TEXTURE_U_COLOR  = 'ShaderPositionTexture_uColor'
cc.SHADER_POSITION_U_COLOR  = 'ShaderPosition_uColor'
cc.UNIFORM_ALPHA_TEST_VALUE_S   = 'CC_AlphaValue'
cc.UNIFORM_COS_TIME_S   = 'CC_CosTime'
cc.UNIFORM_MV_MATRIX_S  = 'CC_MVMatrix'
cc.UNIFORM_MVP_MATRIX_S = 'CC_MVPMatrix'
cc.UNIFORM_P_MATRIX_S   = 'CC_PMatrix'
cc.UNIFORM_RANDOM01_S   = 'CC_Random01'
cc.UNIFORM_SAMPLER_S    = 'CC_Texture0'
cc.UNIFORM_SIN_TIME_S   = 'CC_SinTime'
cc.UNIFORM_TIME_S   = 'CC_Time'

cc.PLATFORM_OS_WINDOWS = 0
cc.PLATFORM_OS_LINUX   = 1
cc.PLATFORM_OS_MAC     = 2
cc.PLATFORM_OS_ANDROID = 3
cc.PLATFORM_OS_IPHONE  = 4
cc.PLATFORM_OS_IPAD    = 5
cc.PLATFORM_OS_BLACKBERRY = 6
cc.PLATFORM_OS_NACL    = 7
cc.PLATFORM_OS_EMSCRIPTEN = 8
cc.PLATFORM_OS_TIZEN   = 9
cc.PLATFORM_OS_WINRT   = 10
cc.PLATFORM_OS_WP8     = 11

cc.LANGUAGE_ENGLISH    = 0
cc.LANGUAGE_CHINESE    = 1
cc.LANGUAGE_FRENCH     = 2
cc.LANGUAGE_ITALIAN    = 3
cc.LANGUAGE_GERMAN     = 4
cc.LANGUAGE_SPANISH    = 5
cc.LANGUAGE_RUSSIAN    = 6
cc.LANGUAGE_KOREAN     = 7
cc.LANGUAGE_JAPANESE   = 8
cc.LANGUAGE_HUNGARIAN  = 9
cc.LANGUAGE_PORTUGUESE = 10
cc.LANGUAGE_ARABIC     = 11

cc.NODE_ON_ENTER       = 0
cc.NODE_ON_EXIT        = 1
cc.NODE_ON_ENTER_TRANSITION_DID_FINISH = 2
cc.NODE_ON_EXIT_TRANSITION_DID_START   = 3
cc.NODE_ON_CLEAN_UP    = 4

cc.Handler = cc.Handler or {}
cc.Handler.NODE            = 0
cc.Handler.MENU_CLICKED    = 1
cc.Handler.CALLFUNC        = 2
cc.Handler.SCHEDULE        = 3
cc.Handler.TOUCHES         = 4
cc.Handler.KEYPAD          = 5
cc.Handler.ACCELEROMETER   = 6
cc.Handler.CONTROL_TOUCH_DOWN = 7
cc.Handler.CONTROL_TOUCH_DRAG_INSIDE = 8
cc.Handler.CONTROL_TOUCH_DRAG_OUTSIDE = 9
cc.Handler.CONTROL_TOUCH_DRAG_ENTER = 10
cc.Handler.CONTROL_TOUCH_DRAG_EXIT  = 11
cc.Handler.CONTROL_TOUCH_UP_INSIDE  = 12
cc.Handler.CONTROL_TOUCH_UP_OUTSIDE = 13
cc.Handler.CONTROL_TOUCH_UP_CANCEL  = 14
cc.Handler.CONTROL_VALUE_CHANGED    = 15
cc.Handler.WEBSOCKET_OPEN           = 16
cc.Handler.WEBSOCKET_MESSAGE        = 17
cc.Handler.WEBSOCKET_CLOSE          = 18
cc.Handler.WEBSOCKET_ERROR          = 19
cc.Handler.GL_NODE_DRAW             = 20
cc.Handler.SCROLLVIEW_SCROLL        = 21
cc.Handler.SCROLLVIEW_ZOOM          = 22
cc.Handler.TABLECELL_TOUCHED        = 23
cc.Handler.TABLECELL_HIGHLIGHT      = 24
cc.Handler.TABLECELL_UNHIGHLIGHT    = 25
cc.Handler.TABLECELL_WILL_RECYCLE   = 26
cc.Handler.TABLECELL_SIZE_FOR_INDEX = 27
cc.Handler.TABLECELL_AT_INDEX       = 28
cc.Handler.TABLEVIEW_NUMS_OF_CELLS  = 29
cc.Handler.HTTPREQUEST_STATE_CHANGE = 30
cc.Handler.ASSETSMANAGER_PROGRESS = 31
cc.Handler.ASSETSMANAGER_SUCCESS  = 32
cc.Handler.ASSETSMANAGER_ERROR    = 33
cc.Handler.STUDIO_EVENT_LISTENER  = 34
cc.Handler.ARMATURE_EVENT         = 35
cc.Handler.EVENT_ACC              = 36
cc.Handler.EVENT_CUSTIOM          = 37
cc.Handler.EVENT_KEYBOARD_PRESSED = 38
cc.Handler.EVENT_KEYBOARD_RELEASED = 39
cc.Handler.EVENT_TOUCH_BEGAN      = 40
cc.Handler.EVENT_TOUCH_MOVED      = 41
cc.Handler.EVENT_TOUCH_ENDED      = 42
cc.Handler.EVENT_TOUCH_CANCELLED  = 43
cc.Handler.EVENT_TOUCHES_BEGAN    = 44
cc.Handler.EVENT_TOUCHES_MOVED    = 45
cc.Handler.EVENT_TOUCHES_ENDED    = 46
cc.Handler.EVENT_TOUCHES_CANCELLED = 47
cc.Handler.EVENT_MOUSE_DOWN       = 48
cc.Handler.EVENT_MOUSE_UP         = 49
cc.Handler.EVENT_MOUSE_MOVE       = 50
cc.Handler.EVENT_MOUSE_SCROLL     = 51
cc.Handler.EVENT_SPINE            = 52
cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN = 53
cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE = 54
cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE = 55
cc.Handler.EVENT_PHYSICS_CONTACT_SEPARATE = 56
cc.Handler.EVENT_FOCUS = 57
cc.Handler.EVENT_CONTROLLER_CONNECTED = 58
cc.Handler.EVENT_CONTROLLER_DISCONNECTED = 59
cc.Handler.EVENT_CONTROLLER_KEYDOWN = 60
cc.Handler.EVENT_CONTROLLER_KEYUP = 61
cc.Handler.EVENT_CONTROLLER_KEYREPEAT = 62
cc.Handler.EVENT_CONTROLLER_AXIS = 63
cc.Handler.EVENT_SPINE_ANIMATION_START = 64
cc.Handler.EVENT_SPINE_ANIMATION_END = 65
cc.Handler.EVENT_SPINE_ANIMATION_COMPLETE = 66
cc.Handler.EVENT_SPINE_ANIMATION_EVENT = 67


cc.EVENT_UNKNOWN = 0
cc.EVENT_TOUCH_ONE_BY_ONE      = 1
cc.EVENT_TOUCH_ALL_AT_ONCE     = 2
cc.EVENT_KEYBOARD              = 3
cc.EVENT_MOUSE                 = 4
cc.EVENT_ACCELERATION          = 5
cc.EVENT_CUSTOM                = 6

cc.PHYSICSSHAPE_MATERIAL_DEFAULT = {density = 0.0, restitution = 0.5, friction = 0.5}
cc.PHYSICSBODY_MATERIAL_DEFAULT = {density = 0.1, restitution = 0.5, friction = 0.5}
cc.GLYPHCOLLECTION_DYNAMIC = 0
cc.GLYPHCOLLECTION_NEHE    = 1
cc.GLYPHCOLLECTION_ASCII   = 2
cc.GLYPHCOLLECTION_CUSTOM  = 3

cc.ResolutionPolicy =
{
    EXACT_FIT = 0,
    NO_BORDER = 1,
    SHOW_ALL  = 2,
    FIXED_HEIGHT  = 3,
    FIXED_WIDTH  = 4,
    UNKNOWN  = 5,
}

cc.LabelEffect =
{
    NORMAL  = 0,
    OUTLINE = 1,
    SHADOW  = 2,
    GLOW    = 3,
}

cc.LabelOverflow =
{
    NONE = 0,
    CLAMP = 1,
    SHRINK = 2,
    RESIZE_HEIGHT = 3
};

cc.KeyCodeKey =
{
    "KEY_NONE",
    "KEY_PAUSE",
    "KEY_SCROLL_LOCK",
    "KEY_PRINT",
    "KEY_SYSREQ",
    "KEY_BREAK",
    "KEY_ESCAPE",
    "KEY_BACKSPACE",
    "KEY_TAB",
    "KEY_BACK_TAB",
    "KEY_RETURN",
    "KEY_CAPS_LOCK",
    "KEY_SHIFT",
    "KEY_RIGHT_SHIFT",
    "KEY_CTRL",
    "KEY_RIGHT_CTRL",
    "KEY_ALT",
    "KEY_RIGHT_ALT",
    "KEY_MENU",
    "KEY_HYPER",
    "KEY_INSERT",
    "KEY_HOME",
    "KEY_PG_UP",
    "KEY_DELETE",
    "KEY_END",
    "KEY_PG_DOWN",
    "KEY_LEFT_ARROW",
    "KEY_RIGHT_ARROW",
    "KEY_UP_ARROW",
    "KEY_DOWN_ARROW",
    "KEY_NUM_LOCK",
    "KEY_KP_PLUS",
    "KEY_KP_MINUS",
    "KEY_KP_MULTIPLY",
    "KEY_KP_DIVIDE",
    "KEY_KP_ENTER",
    "KEY_KP_HOME",
    "KEY_KP_UP",
    "KEY_KP_PG_UP",
    "KEY_KP_LEFT",
    "KEY_KP_FIVE",
    "KEY_KP_RIGHT",
    "KEY_KP_END",
    "KEY_KP_DOWN",
    "KEY_KP_PG_DOWN",
    "KEY_KP_INSERT",
    "KEY_KP_DELETE",
    "KEY_F1",
    "KEY_F2",
    "KEY_F3",
    "KEY_F4",
    "KEY_F5",
    "KEY_F6",
    "KEY_F7",
    "KEY_F8",
    "KEY_F9",
    "KEY_F10",
    "KEY_F11",
    "KEY_F12",
    "KEY_SPACE",
    "KEY_EXCLAM",
    "KEY_QUOTE",
    "KEY_NUMBER",
    "KEY_DOLLAR",
    "KEY_PERCENT",
    "KEY_CIRCUMFLEX",
    "KEY_AMPERSAND",
    "KEY_APOSTROPHE",
    "KEY_LEFT_PARENTHESIS",
    "KEY_RIGHT_PARENTHESIS",
    "KEY_ASTERISK",
    "KEY_PLUS",
    "KEY_COMMA",
    "KEY_MINUS",
    "KEY_PERIOD",
    "KEY_SLASH",
    "KEY_0",
    "KEY_1",
    "KEY_2",
    "KEY_3",
    "KEY_4",
    "KEY_5",
    "KEY_6",
    "KEY_7",
    "KEY_8",
    "KEY_9",
    "KEY_COLON",
    "KEY_SEMICOLON",
    "KEY_LESS_THAN",
    "KEY_EQUAL",
    "KEY_GREATER_THAN",
    "KEY_QUESTION",
    "KEY_AT",
    "KEY_CAPITAL_A",
    "KEY_CAPITAL_B",
    "KEY_CAPITAL_C",
    "KEY_CAPITAL_D",
    "KEY_CAPITAL_E",
    "KEY_CAPITAL_F",
    "KEY_CAPITAL_G",
    "KEY_CAPITAL_H",
    "KEY_CAPITAL_I",
    "KEY_CAPITAL_J",
    "KEY_CAPITAL_K",
    "KEY_CAPITAL_L",
    "KEY_CAPITAL_M",
    "KEY_CAPITAL_N",
    "KEY_CAPITAL_O",
    "KEY_CAPITAL_P",
    "KEY_CAPITAL_Q",
    "KEY_CAPITAL_R",
    "KEY_CAPITAL_S",
    "KEY_CAPITAL_T",
    "KEY_CAPITAL_U",
    "KEY_CAPITAL_V",
    "KEY_CAPITAL_W",
    "KEY_CAPITAL_X",
    "KEY_CAPITAL_Y",
    "KEY_CAPITAL_Z",
    "KEY_LEFT_BRACKET",
    "KEY_BACK_SLASH",
    "KEY_RIGHT_BRACKET",
    "KEY_UNDERSCORE",
    "KEY_GRAVE",
    "KEY_A",
    "KEY_B",
    "KEY_C",
    "KEY_D",
    "KEY_E",
    "KEY_F",
    "KEY_G",
    "KEY_H",
    "KEY_I",
    "KEY_J",
    "KEY_K",
    "KEY_L",
    "KEY_M",
    "KEY_N",
    "KEY_O",
    "KEY_P",
    "KEY_Q",
    "KEY_R",
    "KEY_S",
    "KEY_T",
    "KEY_U",
    "KEY_V",
    "KEY_W",
    "KEY_X",
    "KEY_Y",
    "KEY_Z",
    "KEY_LEFT_BRACE",
    "KEY_BAR",
    "KEY_RIGHT_BRACE",
    "KEY_TILDE",
    "KEY_EURO",
    "KEY_POUND",
    "KEY_YEN",
    "KEY_MIDDLE_DOT",
    "KEY_SEARCH",
    "KEY_DPAD_LEFT",
    "KEY_DPAD_RIGHT",
    "KEY_DPAD_UP",
    "KEY_DPAD_DOWN",
    "KEY_DPAD_CENTER",
    "KEY_ENTER",
    "KEY_PLAY",
}

cc.KeyCode =
{
}

for k,v in ipairs(cc.KeyCodeKey) do
    cc.KeyCode[v] = k - 1
end

cc.KeyCode.KEY_BACK = cc.KeyCode.KEY_ESCAPE
cc.KeyCode.KEY_LEFT_SHIFT = cc.KeyCode.KEY_SHIFT
cc.KeyCode.KEY_LEFT_CTRL  = cc.KeyCode.KEY_CTRL
cc.KeyCode.KEY_LEFT_ALT   = cc.KeyCode.KEY_ALT

cc.EventAssetsManagerEx =
{
    EventCode =
    {
        ERROR_NO_LOCAL_MANIFEST = 0,
        ERROR_DOWNLOAD_MANIFEST = 1,
        ERROR_PARSE_MANIFEST = 2,
        NEW_VERSION_FOUND = 3,
        ALREADY_UP_TO_DATE = 4,
        UPDATE_PROGRESSION = 5,
        ASSET_UPDATED = 6,
        ERROR_UPDATING = 7,
        UPDATE_FINISHED = 8,
        UPDATE_FAILED = 9,
        ERROR_DECOMPRESS = 10
    },
}

cc.AssetsManagerExStatic =
{
    VERSION_ID  = "@version",
    MANIFEST_ID = "@manifest",
}

cc.EventCode =
{
    BEGAN = 0,
    MOVED = 1,
    ENDED = 2,
    CANCELLED = 3,
}

cc.DIRECTOR_PROJECTION_2D = 0
cc.DIRECTOR_PROJECTION_3D = 1

cc.ConfigType =
{
    NONE = 0,
    COCOSTUDIO = 1,
}

cc.AUDIO_INVAILD_ID   = -1
cc.AUDIO_TIME_UNKNOWN  = -1.0

cc.CameraFlag =
{
    DEFAULT = 1,
    USER1 = 2,
    USER2 = 4,
    USER3 = 8,
    USER4 = 16,
    USER5 = 32,
    USER6 = 64,
    USER7 = 128,
    USER8 = 256,
}

cc.CameraBackgroundBrush.BrushType =
{
    NONE = 0,
    DEPTH = 1,
    COLOR = 2,
    SKYBOX = 3,
}

cc.BillBoard_Mode =
{
    VIEW_POINT_ORIENTED = 0,
    VIEW_PLANE_ORIENTED = 1,
}

cc.GLProgram_VERTEX_ATTRIB =
{
    POSITION = 0,
    COLOR = 1,
    TEX_COORD = 2,
    TEX_COORD1 = 3,
    TEX_COORD2 = 4,
    TEX_COORD3 = 5,
    TEX_COORD4 = 6,
    TEX_COORD5 = 7,
    TEX_COORD6 = 8,
    TEX_COORD7 = 9,
    NORMAL = 10,
    BLEND_WEIGHT = 11,
    BLEND_INDEX =12,
    MAX = 13,
    --backward compatibility
    TEX_COORDS = 2,
}

cc.MATRIX_STACK_TYPE =
{
    MODELVIEW = 0,
    PROJECTION = 1,
    TEXTURE = 2,
}

cc.LightType =
{
    DIRECTIONAL = 0,
    POINT = 1,
    SPOT = 2,
    AMBIENT = 3,
}

cc.LightFlag =
{
    LIGHT0  = math.pow(2,0),
    LIGHT1  = math.pow(2,1),
    LIGHT2  = math.pow(2,2),
    LIGHT3  = math.pow(2,3),
    LIGHT4  = math.pow(2,4),
    LIGHT5  = math.pow(2,5),
    LIGHT6  = math.pow(2,6),
    LIGHT7  = math.pow(2,7),
    LIGHT8  = math.pow(2,8),
    LIGHT9  = math.pow(2,9),
    LIGHT10 = math.pow(2,10),
    LIGHT11 = math.pow(2,11),
    LIGHT12 = math.pow(2,12),
    LIGHT13 = math.pow(2,13),
    LIGHT14 = math.pow(2,14),
    LIGHT15 = math.pow(2,15),
}

cc.AsyncTaskPool.TaskType =
{
    TASK_IO = 0,
    TASK_NETWORK = 1,
    TASK_OTHER = 2,
    TASK_MAX_TYPE = 3,
}


cc.RED = cc.c3b(255,0,0)
cc.GREEN = cc.c3b(0,255,0)
cc.BLUE = cc.c3b(0,0,255)
cc.BLACK = cc.c3b(0,0,0)
cc.WHITE = cc.c3b(255,255,255)
cc.YELLOW = cc.c3b(255,255,0)

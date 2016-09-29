
if nil ~= ccs then
    ccs.MovementEventType = {
        start = 0,
        complete = 1,
        loopComplete = 2,
    }

    ccs.InnerActionType = {
        LoopAction = 0,
        NoLoopAction = 1,
        SingleFrame = 2,
    }
end

if nil ~= cc.XMLHttpRequest then
    cc.WEBSOCKET_OPEN     = 0
    cc.WEBSOCKET_MESSAGE  = 1
    cc.WEBSOCKET_CLOSE    = 2
    cc.WEBSOCKET_ERROR    = 3

    cc.WEBSOCKET_STATE_CONNECTING = 0
    cc.WEBSOCKET_STATE_OPEN       = 1
    cc.WEBSOCKET_STATE_CLOSING    = 2
    cc.WEBSOCKET_STATE_CLOSED     = 3

    cc.XMLHTTPREQUEST_RESPONSE_STRING       = 0
    cc.XMLHTTPREQUEST_RESPONSE_ARRAY_BUFFER = 1
    cc.XMLHTTPREQUEST_RESPONSE_BLOB         = 2
    cc.XMLHTTPREQUEST_RESPONSE_DOCUMENT     = 3
    cc.XMLHTTPREQUEST_RESPONSE_JSON         = 4
end

if nil ~= ccexp then
    ccexp.VideoPlayerEvent = {
        PLAYING = 0,
        PAUSED = 1,
        STOPPED= 2,
        COMPLETED =3,
    }
end

if nil ~= cc.Terrain then
    cc.Terrain.CrackFixedType =
    {
        SKIRT = 0,
        INCREASE_LOWER = 1,
    }

    cc.Animate3DQuality =
    {
        QUALITY_NONE = 0,
        QUALITY_LOW  = 1,
        QUALITY_HIGH = 2,
    }
end

if nil ~= sp then
    sp.EventType =
    {
        ANIMATION_START = 0,
        ANIMATION_END = 1,
        ANIMATION_COMPLETE = 2,
        ANIMATION_EVENT = 3,
    }
end

if nil ~= cc.Physics3DComponent then
    cc.Physics3DComponent.PhysicsSyncFlag =
    {
        NONE = 0,
        NODE_TO_PHYSICS = 1,
        PHYSICS_TO_NODE = 2,
        NODE_AND_NODE   = 3,
    }

    cc.Physics3DObject.PhysicsObjType =
    {
        UNKNOWN = 0,
        RIGID_BODY = 1,
    }
end

cc.ControllerKey =
{
    JOYSTICK_LEFT_X = 1000,
    JOYSTICK_LEFT_Y = 1001,
    JOYSTICK_RIGHT_X = 1002,
    JOYSTICK_RIGHT_Y = 1003,

    BUTTON_A = 1004,
    BUTTON_B = 1005,
    BUTTON_C = 1006,
    BUTTON_X = 1007,
    BUTTON_Y = 1008,
    BUTTON_Z = 1009,

    BUTTON_DPAD_UP = 1010,
    BUTTON_DPAD_DOWN = 1011,
    BUTTON_DPAD_LEFT = 1012,
    BUTTON_DPAD_RIGHT = 1013,
    BUTTON_DPAD_CENTER = 1014,

    BUTTON_LEFT_SHOULDER = 1015,
    BUTTON_RIGHT_SHOULDER = 1016,

    AXIS_LEFT_TRIGGER = 1017,
    AXIS_RIGHT_TRIGGER = 1018,

    BUTTON_LEFT_THUMBSTICK = 1019,
    BUTTON_RIGHT_THUMBSTICK = 1020,

    BUTTON_START = 1021,
    BUTTON_SELECT = 1022,

    BUTTON_PAUSE = 1023,
    KEY_MAX = 1024,
}

-- extensions
if nil ~= cc.Control then
    cc.CONTROL_STATE_NORMAL  = 1
    cc.CONTROL_STATE_HIGH_LIGHTED = 2
    cc.CONTROL_STATE_DISABLED = 4
    cc.CONTROL_STATE_SELECTED = 8

    cc.CONTROL_STEPPER_PART_MINUS = 0
    cc.CONTROL_STEPPER_PART_PLUS  = 1
    cc.CONTROL_STEPPER_PART_NONE  = 2

    cc.TABLEVIEW_FILL_TOPDOWN = 0
    cc.TABLEVIEW_FILL_BOTTOMUP = 1

    cc.SCROLLVIEW_SCRIPT_SCROLL = 0
    cc.SCROLLVIEW_SCRIPT_ZOOM   = 1
    cc.TABLECELL_TOUCHED        = 2
    cc.TABLECELL_HIGH_LIGHT     = 3
    cc.TABLECELL_UNHIGH_LIGHT   = 4
    cc.TABLECELL_WILL_RECYCLE   = 5
    cc.TABLECELL_SIZE_FOR_INDEX = 6
    cc.TABLECELL_SIZE_AT_INDEX  = 7
    cc.NUMBER_OF_CELLS_IN_TABLEVIEW = 8

    cc.SCROLLVIEW_DIRECTION_NONE = -1
    cc.SCROLLVIEW_DIRECTION_HORIZONTAL = 0
    cc.SCROLLVIEW_DIRECTION_VERTICAL = 1
    cc.SCROLLVIEW_DIRECTION_BOTH  = 2

    cc.CONTROL_EVENTTYPE_TOUCH_DOWN = 1
    cc.CONTROL_EVENTTYPE_DRAG_INSIDE = 2
    cc.CONTROL_EVENTTYPE_DRAG_OUTSIDE = 4
    cc.CONTROL_EVENTTYPE_DRAG_ENTER = 8
    cc.CONTROL_EVENTTYPE_DRAG_EXIT = 16
    cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE = 32
    cc.CONTROL_EVENTTYPE_TOUCH_UP_OUTSIDE = 64
    cc.CONTROL_EVENTTYPE_TOUCH_CANCEL    = 128
    cc.CONTROL_EVENTTYPE_VALUE_CHANGED   = 256

    cc.EDITBOX_INPUT_MODE_ANY = 0
    cc.EDITBOX_INPUT_MODE_EMAILADDR = 1
    cc.EDITBOX_INPUT_MODE_NUMERIC = 2
    cc.EDITBOX_INPUT_MODE_PHONENUMBER = 3
    cc.EDITBOX_INPUT_MODE_URL = 4
    cc.EDITBOX_INPUT_MODE_DECIMAL = 5
    cc.EDITBOX_INPUT_MODE_SINGLELINE = 6

    cc.EDITBOX_INPUT_FLAG_PASSWORD = 0
    cc.EDITBOX_INPUT_FLAG_SENSITIVE = 1
    cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD = 2
    cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE = 3
    cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_ALL_CHARACTERS = 4

    cc.KEYBOARD_RETURNTYPE_DEFAULT = 0
    cc.KEYBOARD_RETURNTYPE_DONE = 1
    cc.KEYBOARD_RETURNTYPE_SEND = 2
    cc.KEYBOARD_RETURNTYPE_SEARCH = 3
    cc.KEYBOARD_RETURNTYPE_GO = 4

    cc.ASSETSMANAGER_CREATE_FILE  = 0
    cc.ASSETSMANAGER_NETWORK = 1
    cc.ASSETSMANAGER_NO_NEW_VERSION = 2
    cc.ASSETSMANAGER_UNCOMPRESS     = 3

    cc.ASSETSMANAGER_PROTOCOL_PROGRESS =  0
    cc.ASSETSMANAGER_PROTOCOL_SUCCESS  =  1
    cc.ASSETSMANAGER_PROTOCOL_ERROR    =  2
end

if nil ~= ccui then
    ccui.BrightStyle =
    {
        none = -1,
        normal = 0,
        highlight = 1,
    }

    ccui.TextureResType =
    {
        localType = 0,
        plistType = 1,
    }

    ccui.TouchEventType =
    {
        began = 0,
        moved = 1,
        ended = 2,
        canceled = 3,
    }

    ccui.SizeType =
    {
        absolute = 0,
        percent = 1,
    }

    ccui.PositionType = {
        absolute = 0,
        percent = 1,
    }

    ccui.CheckBoxEventType =
    {
        -- CheckBox:addEventListener
        selected = 0,
        unselected = 1,
    }

    ccui.RadioButtonEventType=
    {
            selected = 0,
            unselected = 1
    }

    ccui.RadioButtonGroupEventType=
    {
        select_changed = 0
    }

    ccui.TextFiledEventType =
    {
        attach_with_ime = 0,
        detach_with_ime = 1,
        insert_text = 2,
        delete_backward = 3,
    }

    ccui.LayoutBackGroundColorType =
    {
        none = 0,
        solid = 1,
        gradient = 2,
    }

    ccui.LayoutType =
    {
        ABSOLUTE = 0,
        VERTICAL = 1,
        HORIZONTAL = 2,
        RELATIVE = 3,
    }

    ccui.LayoutParameterType =
    {
        none = 0,
        linear = 1,
        relative = 2,
    }

    ccui.LinearGravity =
    {
        none = 0,
        left = 1,
        top = 2,
        right = 3,
        bottom = 4,
        centerVertical = 5,
        centerHorizontal = 6,
    }

    ccui.RelativeAlign =
    {
        alignNone = 0,
        alignParentTopLeft = 1,
        alignParentTopCenterHorizontal = 2,
        alignParentTopRight = 3,
        alignParentLeftCenterVertical = 4,
        centerInParent = 5,
        alignParentRightCenterVertical = 6,
        alignParentLeftBottom = 7,
        alignParentBottomCenterHorizontal = 8,
        alignParentRightBottom = 9,
        locationAboveLeftAlign = 10,
        locationAboveCenter = 11,
        locationAboveRightAlign = 12,
        locationLeftOfTopAlign = 13,
        locationLeftOfCenter = 14,
        locationLeftOfBottomAlign = 15,
        locationRightOfTopAlign = 16,
        locationRightOfCenter = 17,
        locationRightOfBottomAlign = 18,
        locationBelowLeftAlign = 19,
        locationBelowCenter = 20,
        locationBelowRightAlign = 21,
    }

    ccui.SliderEventType = {
        -- Slider:addEventListener
        percentChanged = 0,
        slideBallDown = 1,
        slideBallUp = 2,
        slideBallCancel = 3
    }

    ccui.LoadingBarDirection = { LEFT = 0, RIGHT = 1}

    ccui.ScrollViewDir = {
        none = 0,
        vertical = 1,
        horizontal = 2,
        both = 3,
    }

    ccui.ScrollViewMoveDir = {
        none = 0,
        up = 1,
        down = 2,
        left = 3,
        right = 4,
    }

    ccui.ScrollviewEventType = {
        -- ListView:addScrollViewEventListener
        -- Scrollview:addEventListener
        scrollToTop =  0,
        scrollToBottom =  1,
        scrollToLeft = 2,
        scrollToRight = 3,
        scrolling = 4,
        bounceTop = 5,
        bounceBottom = 6,
        bounceLeft = 7,
        bounceRight = 8,
    }

    ccui.ListViewDirection = {
        none = 0,
        vertical = 1,
        horizontal = 2,
    }

    ccui.ListViewMoveDirection = {
        none = 0,
        up = 1,
        down = 2,
        left = 3,
        right = 4,
    }

    ccui.ListViewEventType = {
        -- ListView:addEventListener
        ONSELECTEDITEM_START = 0,
        ONSELECTEDITEM_END   = 1,
    }

    ccui.PageViewEventType = {
       -- PageView:addEventListener
       turning = 0,
    }

    ccui.PageViewDirection = {
      HORIZONTAL = 0,
      VERTICAL = 1
    }

    ccui.PVTouchDir = {
        touchLeft = 0,
        touchRight = 1,
        touchUp = 2,
        touchDown = 3
    }

    ccui.ListViewGravity = {
        left = 0,
        right = 1,
        centerHorizontal = 2,
        top = 3,
        bottom = 4 ,
        centerVertical = 5,
    }

    ccui.TextType = {
        SYSTEM = 0,
        TTF    = 1,
    }

    ccui.LayoutComponent.HorizontalEdge = {
        None = 0,
        Left = 1,
        Right = 2,
        Center = 3,
    }

    ccui.LayoutComponent.VerticalEdge = {
        None = 0,
        Bottom = 1,
        Top = 2,
        Center = 3,
    }

    ccui.TextFieldEventType = {
        -- TextField:addEventListener
        ATTACH_WITH_IME = 0,
        DETACH_WITH_IME = 1,
        INSERT_TEXT = 2,
        DELETE_BACKWARD = 3,
    }

    ccui.EditBoxEventType = {
        -- registerScriptEditBoxHandler
        -- unregisterScriptEditBoxHandler
    }
end

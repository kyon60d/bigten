
local MM = {}

function MM.InitModule(config)
    for k,v in pairs(config) do
        local mod = require(v)
        MM[mod.Name] = mod
    end
    for k,v in pairs(MM) do
        if type(v) == "table" and type(v.Import) == "table" then
            local im = v.Import
            for k,v in pairs(im) do
                im[k] = MM[v]-- 对于每个module执行此代码后v的值就改变了，不能再次执行
            end
        end
    end
    MM.InitData()
    MM.ClearData()
end

function MM.InitData()
    MM.ExecuteInterface("InitData")
end

function MM.ClearData()
    MM.ExecuteInterface("ClearData")
end

function MM.ExecuteInterface(iName)
    for k,v in pairs(MM) do
        if type(v) == "table" and type(v[iName]) == "function" then
            v[iName]()
        end
    end
end

return MM

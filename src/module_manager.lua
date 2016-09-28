
local mmgr = {}
local lmgr = {}

function mmgr.GetModule(moduleName)
	return lmgr[moduleName]
end

function mmgr.InitModule(config)
	for k,v in pairs(config) do
		local mod = require(v)
		lmgr[mod.GetModuleName()] = mod
	end
	for k,v in pairs(lmgr) do
		if type(v) == "table" and type(v.GetImportModule) == "function" then
			local im = v.GetImportModule()
			for k,v in pairs(im) do
				im[k] = lmgr[v]-- 对于每个module执行此代码后v的值就改变了，不能再次执行
			end
		end
	end
	mmgr.InitData()
	mmgr.ClearData()
end

function mmgr.InitData()
	mmgr.ExecuteInterface("InitData")
end

function mmgr.ClearData()
	mmgr.ExecuteInterface("ClearData")
end

function mmgr.ExecuteInterface(iName)
	for k,v in pairs(lmgr) do
		if type(v) == "table" and type(v[iName]) == "function" then
			v[iName]()
		end
	end
end

return mmgr

-- 返回一个函数
-- local Mgr = require "module_manager"
-- local mmgr = Mgr(require "module_config")

-- 安全执行
-- mmgr.ExecuteSafe("Ci","Check")

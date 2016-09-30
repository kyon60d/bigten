local path = string.match(debug.getinfo(1,'S').source, "(.+)/[^/]*%.%w+$") .. "/../"
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath(path.."luares/")
package.path = path.."luasrc/"

require "mainlua"
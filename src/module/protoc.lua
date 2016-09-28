
local lmA = {}
function lmA.GetModuleName()
    return "Protoc"
end

local protos = require "network.game_protos"
local parser = require "network.parser"
local pb = require "network.protobuf"
local ByteArray = require "network.byte_array"

function lmA.Register(fileSet)
	parser.register(fileSet,protos)
end

function lmA.Encode(message,t,func,...)
	return pb.encode(message,t,func,...)
end

function lmA.Decode(typename,buffer,length)
	return pb.decode(typename,buffer,length)
end

function lmA.GetMsgHeader(msgid)
    local header = ByteArray.new()
    header:writeInt(msgid)
    header:setEndian(ByteArray.ENDIAN_BIG)
    return header:getPack(1,4)
end

return lmA

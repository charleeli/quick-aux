package.cpath = "./build/luaclib/?.so"
package.path = package.path..";./lualib/?.lua"

local log = require "log"
local enet = require "enet"

local host = enet.host_create()
local server = host:connect("localhost:5678")

local count = 0
while count < 100 do
	local event = host:service(100)
	if event then
		if event.type == "receive" then
			log.info("Got message: ",  event.data)
		else
			log.info("Got event", event.type)
		end
	end

	if count == 8 then
		log.info "sending message"
		server:send("hello world")
	end

	count = count + 1
end

server:disconnect()
host:flush()

log.info"done"

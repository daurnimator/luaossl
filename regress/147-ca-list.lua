#!/usr/bin/env lua

require"regress".export".*"

local n = require "openssl.x509.name".new():add("CN", "HI")
local x = require "openssl.x509".new()
x:setSubject(n)
local c = require "openssl.ssl.context".new()
c:addCAList(x)

local calist = c:getCAList()
check(calist[1])
for k, v in calist[1]:each() do
	check(k == "CN" and v == "HI", "wrong name")
end

say "OK"

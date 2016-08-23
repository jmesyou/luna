IOModule = {}

function IOModule.readFile(filename)
	local f = io.open(filename, "rb")
	local data = f:read("*a")
	f:close()
	return data
end

return IOModule

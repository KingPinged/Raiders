local m = {}
m.__index = m

function m.new(data)
	local class = setmetatable({}, m)
	class.player = data.player

	return class
end

function m:SetUp()
	local base = {}

	for _, room in ipairs(base) do
	end
end

function m:Destroy()
	--NOTE: this may not work as intended
	self = nil
end

return function(this)
	return m
end

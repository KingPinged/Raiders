local room = {}
room.__index = room

function room.new(data)
	local class = setmetatable({}, room)
	class.setup = data.setup

	return class
end

--TODO
--Used when checking if a player is in range accounting for obstacles
function room:InSight(pos1, pos2)
	local x1, y1 = pos1[1], pos1[2]
	local x2, y2 = pos2[1], pos2[2]
	local dx, dy = x2 - x1, y2 - y1
	local steps = math.max(math.abs(dx), math.abs(dy))
	local x, y = x1, y1
	local stepx, stepy = dx / steps, dy / steps
	for i = 1, steps do
		x, y = x + stepx, y + stepy
		if self.setup[x][y] == 1 then
			return false
		end
	end
	return true
end

function room:SetUp() end

return function(this)
	return room
end

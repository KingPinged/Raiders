local Mobs = require(script.Parent)()

local zombie = {}
setmetatable(zombie, Mobs)
zombie.__index = zombie

function zombie.new(data)
	local class = Mobs.new(data)
	setmetatable(class, zombie)
	class.originalPosition = data.position
	class.position = data.position
	class.room = data.room
	class.moving = false
	class.health = 20
	class.direction = nil

	return class
end

--TODO invalid pseudocode here
function zombie:TileUpdate()
	local room = self.room
	local player = self.player
	--if player is in front of zombie row or column
	if (player.position[0] == self.positiion[0]) or (player.position[1] == self.position[1]) then
		--if player is in line of sight
		if room:InSight(self.position, player.position) then
			--todo: update zombie to move towards player
			self:Update()
		end
	end
end

return function(this)
	return zombie
end

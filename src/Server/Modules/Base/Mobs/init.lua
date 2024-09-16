local Mob = {}
Mob.__index = Mob

local main = nil

function Mob.new(data)
	local class = setmetatable({}, Mob)

	--the original position will be used to reset the mob when leaving room
	class.originalPosition = data.position
	class.position = data.position
	class.room = data.room
	class.speed = 20
	class.humanoid = data.humanoid

	class.Clean = main.Packages.janitor.new()

	return class
end

--TODO differ between A star and just normal movement
--TODO humanoid must be a real humanoid
function Mob:MoveTo(pos)
	self.Clean:AddPromise(main.Packages.promise.new(function(resolve, reject, onCancel)
		local targetReached = false

		-- listen for the humanoid reaching its target
		self.Clean:Add(
			self.humanoid.MoveToFinished:Connect(function(reached)
				targetReached = true
			end),
			"Disconnect"
		)

		self.humanoid:MoveTo(pos)

		main.Packages.promise.new(function(resolve, reject, onCancel)
			while not targetReached do
				--TODO update the tile of mob in room

				--TODO if the path is blocked

				--TODO detect player in radius
			end
			resolve()
		end)
	end))
end

function Mob:Update() end

return function(this)
	main = this
	return Mob
end

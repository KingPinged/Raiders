--[[
--File: PlayerAdded.lua
--File Created: Tuesday, 21st May 2024 5:34:15 am
--Last Modified: Friday, 24th May 2024 3:12:37 am
--Copyright Mason Lee
--
--TOD: 
--Description: 
--]]

type Self = {
	Players: { [number]: any },
	Modules: { [string]: any },
	Packages: Folder,
}
function playerAdded(self: Self, player)
	if self.Players[player.UserId] then
		return
	end

	self.Players[player.UserId] = {}

	self.Packages.

	local data = self.Modules.Database:PlayerAdded(player)
end

return function(self: Self)
	local PlayerServe = game:GetService("Players")

	PlayerServe.PlayerAdded:Connect(function(player)
		playerAdded(self, player)
	end)

	for _, player in ipairs(PlayerServe:GetPlayers()) do
		task.spawn(playerAdded, self, player)
	end
end

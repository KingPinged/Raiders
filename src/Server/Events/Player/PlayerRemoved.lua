--[[
--File: PlayerRemoved.lua
--File Created: Friday, 24th May 2024 2:37:15 am
--Last Modified: Friday, 24th May 2024 2:37:35 am
--Copyright Mason Lee
--
--TOD: 
--Description: 
--]]

function PlayerRemoved(self, player)
	if not self.Players[player.UserId] then
		return
	end

	self.Players[player.UserId] = nil
end

return function(self)
	local PlayerServe = game:GetService("Players")

	PlayerServe.PlayerRemoving:Connect(function(player)
		PlayerRemoved(self, player)
	end)

	for _, player in ipairs(PlayerServe:GetPlayers()) do
		PlayerRemoved(self, player)
	end
end

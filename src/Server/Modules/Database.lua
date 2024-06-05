--[[
--File: Database.lua
--File Created: Friday, 24th May 2024 3:12:18 am
--Last Modified: Friday, 24th May 2024 3:53:40 am
--Copyright Mason Lee
--
--TOD: 
--Description: 
--]]
--
local Players = game:GetService("Players")

type PlayerData = {
	Base: {},
	Moderation: {},
	LastOnline: number,
	Tutorial: boolean,
}

local PlayerTemplate: PlayerData = {
	Base = {},
	Moderation = {},
	LastOnline = 0,
	Tutorial = false,
}

local Database = {}

local Profiles = {}

function Database:Init(this)
	local ProfileService = this.Packages.ProfileService

	self.ProfileStore = ProfileService.GetProfileStore("PlayerData", PlayerTemplate)
end

--TODO make kicks managed in a kick module
function Database:PlayerAdded(player: Player)
	local profile = self.ProfileStore:LoadProfileAsync("Player_" .. player.UserId, "ForceLoad")

	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
		profile:ListenToRelease(function()
			Profiles[player] = nil
			-- The profile could've been loaded on another Roblox server:
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			Profiles[player] = profile
			return profile
		else
			-- Player left before the profile loaded:
			profile:Release()
			return false
		end
	else
		-- The profile couldn't be loaded possibly due to other
		--   Roblox servers trying to load this profile at the same time:
		player:Kick()
		return false
	end
end

function Database:PlayerRemoved(player: Player)
	local profile = Profiles[player]

	if profile then
		profile:Release()
	end
end

return function(this)
	Database:Init(this)

	return Database
end

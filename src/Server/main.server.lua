--[[
--File: main.server.lua
--File Created: Wednesday, 15th May 2024 3:49:47 pm
--Last Modified: Friday, 24th May 2024 3:24:12 am
--Copyright Mason Lee
--
--TOD: 
--Description: 
--]]

-- Use datastore for Bases permanent data, then copy into a memory table for easier access to global bases

-- main server framework

local ReplicatedStorage = game:GetService("ReplicatedStorage")

--wait for Packages to load then use dependency injection
local Packages = ReplicatedStorage:WaitForChild("Packages")
local ServerPackages = script.Parent:WaitForChild("ServerPackages")
local Events = script.Parent:WaitForChild("Events")
local Modules = script.Parent:WaitForChild("Modules")

--TODO: dont use OOP for this class. It may not be needed this way!

--Class for MAIN
local main = {}
main.__index = main

function main.new()
	local class = setmetatable({}, main)

	--these init properties may need to be moved to a different module for organization
	class.Players = {}

	-- load all packages
	local h = {}
	for _, package in ipairs(Packages:GetChildren()) do
		h[package.Name] = require(package)
	end

	-- load all server packages
	local sh = {}
	for _, package in ipairs(ServerPackages:GetChildren()) do
		sh[package.Name] = require(package)
	end

	class.Packages = h

	-- load all modules
	local m = {}
	for _, module in ipairs(Modules:GetDescendants()) do
		if not module:IsA("ModuleScript") then
			continue
		end
		m[module.Name] = require(module)(class)
	end

	class.Modules = m
	class.ServerPackages = sh

	-- must go after packages and modules because we use them
	--load all events
	for _, event in ipairs(Events:GetDescendants()) do
		if not event:IsA("ModuleScript") then
			continue
		end
		task.spawn(require(event)(class))
	end

	return class
end

function main:ObjectMethod()
	print(self.Property)
end

--[[
	Networker for creating and fetching various events during runtime.
]]

-- @classmod Network
-- @author FaKeXSwing
-- @date 2025-10-01

----------------------------------
--        DEPENDENCIES
----------------------------------

local Network = {}
export type networkEvent =
	RemoteEvent |
	RemoteFunction |
	BindableEvent |
	BindableFunction |
	UnreliableRemoteEvent

----------------------------------
--    SERVICES & PRIMARY OBJECTS
----------------------------------

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

----------------------------------
--        CONFIG VARIABLES
----------------------------------

local NETWORK_ROOT = ReplicatedStorage:FindFirstChild("Network")
if not NETWORK_ROOT then
	NETWORK_ROOT = Instance.new("Folder")
	NETWORK_ROOT.Name = "Network"
	NETWORK_ROOT.Parent = ReplicatedStorage
end

local IS_SERVER = RunService:IsServer()
local NETWORK_CLASSES = {
	"RemoteEvent",
	"RemoteFunction",
	"BindableEvent",
	"BindableFunction",
	"UnreliableRemoteEvent",
}

----------------------------------
--        PRIVATE FUNCTIONS
----------------------------------

function Network:__create(className, eventName): networkEvent
	assert(className, "A class name must be provided for this function!")
	assert(eventName, "An event name must be provided for this function!")
	assert(IS_SERVER, ":Fetch must be called from the server to create an event!")
	
	local eventInstance = Instance.new(className)
	eventInstance.Name = eventName
	eventInstance.Parent = NETWORK_ROOT
	return eventInstance
end
 
function Network:__find(eventName): networkEvent
	return NETWORK_ROOT:FindFirstChild(eventName)
end

----------------------------------
--        PUBLIC FUNCTIONS
----------------------------------

function Network:Get(className, eventName): networkEvent
	assert(className, "A class name must be provided for this function!")
	assert(eventName, "An event name must be provided for this function!")
	assert(table.find(NETWORK_CLASSES, className), ("%s is not a valid class name!"):format(className))
	return self:__find(eventName) or self:__create(className, eventName)
end

return Network
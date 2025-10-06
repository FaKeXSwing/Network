# Network
A utility for fetching and creating classes such as RemoteEvents during runtime.

## Getting Started
```lua
local Network = require(pathToModule)

-- Creates or fetches specified class under Network folder inside of ReplicatedStorage.
-- Instances can only be created from a server context. Client fetches existing instances only.
Network:Get(className, instanceName): RemoteEvent | RemoteFunction | BindableEvent | BindableFunction | UnreliableRemoteEvent
```
### Example
```lua
local Network = require(pathToModule)
local RemoteEvent = Network:Get("RemoteEvent", "ExampleEvent")

-- // Client Context \\ --
RemoteEvent:FireServer(...)

-- // Server Context \\ --
RemoteEvent.OnServerEvent:Connect(Callback)
```

local function GetService(serv: string)
	return game.GetService(game, serv)
end
local WaitForChild = game.WaitForChild
-- Services
local Players = GetService('Players')
local ReplicatedStorage = GetService('ReplicatedStorage')
-- LocalPlayer
local LocalPlayer = Players.LocalPlayer
-- Variables
local Functions = {}
local RespawnedFunction
local Character, Humanoid, HumanoidRootPart

-- Functions

function Functions.GetCharacter()
	return Character
end
function Functions.GetHumanoid()
	return Humanoid
end
function Functions.GetRootPart()
	return HumanoidRootPart
end

function Functions.ValidCharacter(m)
	return m and m:FindFirstChild('Humanoid') and m.Humanoid.Health > 0 and m.PrimaryPart
end

function Functions.WithinDistance(p,d)
	return Character and LocalPlayer:DistanceFromCharacter(p) <= d
end

function Functions.SetRespawn(f)
	RespawnedFunction = f
end
-- Respawning
local function CharacterAdded(m)
	Character = m
	Humanoid = WaitForChild(Character, 'Humanoid')
	HumanoidRootPart = Humanoid.RootPart
	repeat task.wait() until RespawnedFunction
	RespawnedFunction(Character, Humanoid, HumanoidRootPart)
end
LocalPlayer.CharacterAdded:Connect(CharacterAdded)
if (LocalPlayer.Character) then
	task.spawn(CharacterAdded, LocalPlayer.Character)
end
-- Set
Functions['GetService'] = GetService
return Functions

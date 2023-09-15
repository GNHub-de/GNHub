local UserInputService = game:GetService("UserInputService")

if UserInputService.TouchEnabled == false and UserInputService.MouseEnabled == true and UserInputService.KeyboardEnabled == true then
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
end

if game.PlaceId ~= 286090429 then
    return
end

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local GNHub = loadstring(game:HttpGetAsync("http://45.146.255.5:8100/UI%20222435-%20GNHub5345341.lua"))()
loadstring(game:HttpGetAsync("http://45.146.255.5:8100/ESP%20-%20GNHub34324234.lua"))()
local Aimbot = loadstring(game:HttpGetAsync("http://45.146.255.5:8100/Aimbot%20-%20GNHub137773.lua"))()
local Players = game:GetService("Players")
local BodyPart = nil
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapons = game.ReplicatedStorage.Weapons:GetChildren()
local Toggle = {}
local Value = {}
local Settings = {
    Toggle = {
        InfiniteJump = false,
        Speed = false,
        Noclip = false,
        WallBang = false,
        InstantRespawn = false,
        HitBoxes = false,
        TeamCheck = false,
        Norecoil = false,
        TPBack = false,
        TeamCheckAB = false,
        isVisible = 1,
        HitBoxesTeamChack = false,
        HitBoxesTeamChackbp = false,
        oneshot = false,
        Silentaim = false
    },
    Value = {
        Speed = 258,
        SpeedBackup = Workspace[LocalPlayer.Name].Humanoid.WalkSpeed,
        HitBoxes = Vector3.new(25, 25, 25)
    }
}

game:GetService("UserInputService").JumpRequest:Connect(
    function()
        if Settings.Toggle.InfiniteJump and LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
)

local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

local MT = getrawmetatable(game)
local OldNC = MT.__namecall
local OldIDX = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod()
    if Method == "FindPartOnRayWithIgnoreList" and Settings.Toggle.WallBang and not checkcaller() then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return OldNC(self, unpack(Args))
        end
    end
    return OldNC(self, ...)
end)

local speedid = Workspace[LocalPlayer.Name].Humanoid
local speedy = Settings.Value.Speed
local ss = nil
ss = hookmetamethod(game, "__index", function(Self, Key)
    if not checkcaller() and Self == speedid and Key == "WalkSpeed" then
        Settings.Value.Speed = Settings.Value.Speed
        speedy = Settings.Value.Speed
        if Settings.Toggle.Speed then
            Workspace[LocalPlayer.Name].Humanoid.WalkSpeed = 258
            return 258
        else
            Workspace[LocalPlayer.Name].Humanoid.WalkSpeed = 20
            return 20
        end
    end
    return ss(Self, Key)
end)


MT.__index = newcclosure(function(self, K)
    if K == "Clips" and Settings.Toggle.WallBang then
        return workspace.Map
    end
    return OldIDX(self, K)
end)
setreadonly(MT, true)

game.RunService.Heartbeat:Connect(
    function()
        if Settings.Toggle.InstantRespawn then
            if
                game.Players.LocalPlayer.NRPBS.Health.Value <= 0 and
                    game.Players.LocalPlayer.Status.Team.Value ~= "Spectator"
             then
                getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Client).reviveme = true
            end
        end
    end
)

game.RunService.Heartbeat:Connect(
    function()
        if game:GetService("ReplicatedStorage").wkspc.FFA.Value then
            _G.TeamCheck = false
            Aimbot.TeamCheck = false
            Settings.Toggle.HitBoxesTeamChack = false
        else
            _G.TeamCheck = Settings.Toggle.TeamCheck
            Aimbot.TeamCheck = Settings.Toggle.TeamCheckAB
            Settings.Toggle.HitBoxesTeamChack = Settings.Toggle.HitBoxesTeamChackbp
        end
    end
)

local GUI =
    GNHub:new(
    {
        name = "Arsenal"
    }
)

local PlayerTab =
    GUI:CreateTab(
    {
        name = "Player"
    }
)
PlayerTab:CreateSection(
    {
        text = "Player"
    }
)
PlayerTab:CreateToggle(
    {
        text = "Noclip",
        callback = function(t)
            if t then
                noclip()
            else
                clip()
            end
        end
    }
)
PlayerTab:CreateSection(
    {
        text = "Speed"
    }
)
PlayerTab:CreateToggle(
    {
        text = "Max Speed",
        callback = function(t)
            Settings.Toggle.Speed = t
        end
    }
)
if not UserInputService.TouchEnabled then
PlayerTab:CreateSection(
    {
        text = "Jump"
    }
)
PlayerTab:CreateToggle(
    {
        text = "Inf Jump",
        callback = function(t)
            Settings.Toggle.InfiniteJump = t
        end
    }
)
end

PlayerTab:Holder()

local WeaponTab =
    GUI:CreateTab(
    {
        name = "Weapon"
    }
)

WeaponTab:CreateSection(
    {
        text = "Weapon Mods"
    }
)

WeaponTab:CreateToggle(
    {
        text = "Infinite Ammo",
        callback = function(v)
            if v == true then
                for i, d in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do
                    if d.Name:lower():find("curse") then
                        d.Value = "Infinite Ammo"
                    end
                end
            else
                for i, d in pairs(game:GetService("ReplicatedStorage").wkspc:GetDescendants()) do
                    if d.Name:lower():find("curse") then
                        d.Value = "None"
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Fast Firerate",
        callback = function(v)
            if v == true then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "FireRate" then
                            c.Value = 0.02
                        end
                    end
                end
            else
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "FireRate" then
                            c.Value = 0.8
                        end
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Fast Reload Time",
        callback = function(v)
            if v == true then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "ReloadTime" then
                            c.Value = 0.01
                        end
                    end
                end
            else
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "ReloadTime" then
                            c.Value = 1
                        end
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "No recoil",
        callback = function(v)
            Settings.Toggle.Norecoil = v
            if v == true then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "MaxSpread" or d.Name == "Spread" or d.Name == "RecoilControl" then
                            c.Value = 0
                        end
                    end
                end
            elseif v == false then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "MaxSpread" or d.Name == "Spread" or d.Name == "RecoilControl" then
                            c.Value = 1
                        end
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Automatic Weapons",
        callback = function(v)
            if v == true then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "Auto" then
                            c.Value = true
                        end
                    end
                end
            else
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "Auto" then
                            c.Value = false
                        end
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Infinite Range",
        callback = function(v)
            if v == true then
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "Range" then
                            c.Value = 1000
                        end
                    end
                end
            else
                for i, d in next, Weapons do
                    for i, c in next, d:GetChildren() do
                        for i, x in next, getconnections(c.Changed) do
                            x:Disable()
                        end
                        if c.Name == "Range" then
                            c.Value = 1000
                        end
                    end
                end
            end
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Instant Equip",
        callback = function(v)
            if v then
                for _, d in pairs(Weapons) do
                    if d:FindFirstChild("EquipTime") then
                        d.EquipTime.Value = 0.00001
                    end
                end
            else
                for _, d in pairs(Weapons) do
                    if d:FindFirstChild("EquipTime") then
                        d.EquipTime.Value = 1
                    end
                end
            end
        end
    }
)

WeaponTab:CreateSection(
    {
        text = "Cosmetic"
    }
)

WeaponTab:CreateToggle(
    {
        text = "Rainbow Weapons",
        callback = function(v)
            local c = 1
            local function R(X)
                return math.acos(math.cos(X * math.pi)) / math.pi
            end
            game:GetService("RunService").RenderStepped:Connect(
                function()
                    if game.Workspace.Camera:FindFirstChild("Arms") then
                        for i, s in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                            if s.ClassName == "MeshPart" then
                                if v == true then
                                    s.Color = Color3.fromHSV(R(c), 1, 1)
                                    c = c + .0001
                                end
                            end
                        end
                    end
                end
            )
        end
    }
)

WeaponTab:CreateToggle(
    {
        text = "Rainbow Arms",
        callback = function(v)
            local c = 1
            local function Re(X)
                return math.acos(math.cos(X * math.pi)) / math.pi
            end
            game:GetService("RunService").RenderStepped:Connect(
                function()
                    if game.Workspace.Camera:FindFirstChild("Arms") then
                        for i, s in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                            if s.ClassName == "Part" then
                                if v == true then
                                    s.Color = Color3.fromHSV(Re(c), 1, 1)
                                    c = c + .0001
                                end
                            end
                        end
                    end
                end
            )
        end
    }
)

WeaponTab:Holder()

local CombetTab =
    GUI:CreateTab(
    {
        name = "Combet"
    }
)

CombetTab:CreateSection({text = "LocalPlayer"})

CombetTab:CreateToggle(
    {
        text = "Instant Respawn (does not work 100%)",
        callback = function(v)
            Settings.Toggle.InstantRespawn = v
        end
    }
)


CombetTab:CreateToggle(
    {
        text = "Auto Heal",
        callback = function(v)
            spawn(
                function()
                    while v do
                        wait()
                        pcall(
                            function()
                                for i, s in pairs(Workspace.Debris:GetChildren()) do
                                    if s.Name == "DeadHP" then
                                        s.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                    end
                                end
                            end
                        )
                    end
                end
            )
        end
    }
)


CombetTab:CreateSection({text = "Combet"})

CombetTab:CreateToggle(
    {
        text = "WallBang (Semi)",
        callback = function(v)
            Settings.Toggle.WallBang = v
        end
    }
)

CombetTab:CreateToggle(
    {
        text = "Silentaim",
        callback = function(v)
            Settings.Toggle.Silentaim = v
        end
    }
)

CombetTab:Holder()

local ESPTab =
    GUI:CreateTab(
    {
        name = "ESP"
    }
)

ESPTab:CreateToggle(
    {
        text = "Boxes",
        callback = function(value)
            _G.BoxEspI = value
        end
    }
)

ESPTab:CreateToggle(
    {
        text = "Tracer",
        callback = function(value)
            _G.TracerEspI = value
        end
    }
)

if not UserInputService.TouchEnabled then
ESPTab:CreateToggle(
    {
        text = "Names",
        callback = function(value)
            _G.NameEspI = value
        end
    }
)
end

ESPTab:CreateToggle(
    {
        text = "Distance",
        callback = function(value)
            _G.DistanceEspI = value
        end
    }
)

ESPTab:CreateToggle(
    {
        text = "Team Check",
        callback = function(value)
            _G.TeamCheck = value
            Settings.Toggle.TeamCheck = value
        end
    }
)

ESPTab:CreateToggle(
    {
        text = "Team Color",
        callback = function(value)
            _G.TeamColor = value
        end
    }
)

ESPTab:CreateColorpicker(
    {
        text = "ESP Color",
        callback = function(value)
            _G.BoxEspColor = value
            _G.TracerEspColor = value
        end
    }
)

ESPTab:CreateColorpicker(
    {
        text = "Text Color",
        callback = function(value)
            _G.TextColor = value
        end
    }
)

ESPTab:Holder()

local AimbotTab =
    GUI:CreateTab(
    {
        name = "Aimbot"
    }
)

AimbotTab:CreateToggle(
    {
        text = "Toggle Aimbot",
        callback = function(value)
            Aimbot.Aimbot = value
        end
    }
)

if not UserInputService.TouchEnabled then
    AimbotTab:CreateKeybind(
        {
            text = "Aimbot bind",
            default = "MouseButton2",
            defaultkey = Enum.UserInputType.MouseButton2,
            callback = function(value)
                Aimbot.Key = value.Name
            end
        }
    )
end

AimbotTab:CreateToggle(
    {
        text = "Fov",
        callback = function(value)
            Aimbot.CircleVisible = value
        end
    }
)

AimbotTab:CreateToggle(
    {
        text = "Team Check",
        callback = function(value)
            Aimbot.TeamCheck = value
            Settings.Toggle.TeamCheckAB = value
        end
    }
)

AimbotTab:CreateToggle(
    {
        text = "Alive Check",
        callback = function(value)
            Aimbot.AliveCheck = value
        end
    }
)

local AimParts =
    AimbotTab:CreateDropdown(
    {
        text = "Part",
        default = "Head",
        callback = function(value)
            Aimbot.Part = value
        end
    }
)

AimParts:Add("Head", "Head")
AimParts:Add("HumanoidRootPart", "HumanoidRootPart")
AimParts:Add("LeftUpperArm", "LeftUpperArm")
AimParts:Add("LeftLowerArm", "LeftLowerArm")
AimParts:Add("RightUpperArm", "RightUpperArm")
AimParts:Add("RightLowerArm", "RightLowerArm")
AimParts:Add("LeftUpperLeg", "LeftUpperLeg")
AimParts:Add("LeftLowerLeg", "LeftLowerLeg")
AimParts:Add("RightUpperLeg", "RightUpperLeg")
AimParts:Add("RightLowerLeg", "RightLowerLeg")

AimbotTab:CreateSlider(
    {
        text = "Fov Radius",
        min = 1,
        max = 2000,
        default = 80,
        callback = function(v)
            Aimbot.CircleRadius = v
        end
    }
)

AimbotTab:CreateColorpicker(
    {
        text = "Fov Color",
        callback = function(value)
            Aimbot.CircleColor = value
        end
    }
)

AimbotTab:Holder()

GUI:Holder()

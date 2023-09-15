if not game:IsLoaded() then
    game.Loaded:Wait()
end

local GNHub = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/libs/UI%20-%20GNHub.lua"))()
        local Aimbot = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/libs/Aimbot%20-%20GNHub.lua"))()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/libs/ESP%20-%20GNHub.lua"))()
local UserInputService = game.UserInputService
local LocalPlayer = game:GetService("Players").LocalPlayer
local Toggle = {}
local Value = {}
local Settings = {
    Toggle = {
        InfiniteJump = false,
        Jump = false,
        Speed = false,
        Noclip = false
    },
    Value = {
        Jump = 255,
        JumpBackup = LocalPlayer.Character.Humanoid.JumpPower,
        Speed = 258,
        SpeedBackup = LocalPlayer.Character.Humanoid.WalkSpeed
    }
}

function Speed()
    while true do
        wait()
        if Settings.Toggle.Speed then
            Settings.Value.Speed = Settings.Value.Speed
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Value.Speed
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Value.SpeedBackup
        end
    end
end

function Jump()
    while true do
        wait()
        if Settings.Toggle.Jump then
            Settings.Value.Jump = Settings.Value.Jump
            LocalPlayer.Character.Humanoid.JumpPower = Settings.Value.Jump
        else
            LocalPlayer.Character.Humanoid.JumpPower = Settings.Value.JumpBackup
        end
    end
end

function Noclip()
    while Settings.Toggle.Noclip do
        if Settings.Toggle.Noclip and LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
        wait()
    end
end

game:GetService("UserInputService").JumpRequest:Connect(
    function()
        if Settings.Toggle.InfiniteJump and LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end
)

local GUI =
    GNHub:new(
    {
        name = "Universal"
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
            Settings.Toggle.Noclip = t
            Noclip()
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
        text = "Speed",
        callback = function(t)
            Settings.Toggle.Speed = t
            Speed()
        end
    }
)
PlayerTab:CreateSlider(
    {
        text = "Speed Value",
        min = 16,
        max = 500,
        default = 258,
        callback = function(v)
            Settings.Value.Speed = v
        end
    }
)
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
PlayerTab:CreateToggle(
    {
        text = "Jump",
        callback = function(t)
            Settings.Toggle.Jump = t
            Jump()
        end
    }
)
PlayerTab:CreateSlider(
    {
        text = "Jump Value",
        min = 10,
        max = 500,
        default = 255,
        callback = function(v)
            Settings.Value.Jump = v
        end
    }
)
PlayerTab:Holder()
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

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 4639625707 then
    return
end
_G.Waitclaimbase = false
local LocalPlayer = game:GetService("Players").LocalPlayer
-- game:GetService("Players")["5z5fh345dd"].PlayerGui.TeamSelectGui
for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
    if (v.Name:find("TeamSelectGui")) then
        info("GNHUB: Claim a base first")
        _G.Waitclaimbase = true
    end
end

local function startup()
    if _G.Waitclaimbase == false then
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local Players = game:GetService("Players")
        local UserInputService = game.UserInputService
        local NoFallDamgebitch = Instance.new("RemoteEvent")
        NoFallDamgebitch.Name = "NFDB"
        local Toggle = {}
        local Value = {}
        local ESP = {}
        local Settings = {
            Toggle = {
                AutoMoney = false,
                InfiniteAmmo = false,
                InfiniteJump = false,
                Jump = false,
                AFD = false,
                Speed = false,
                Noclip = false,
                NoFallDamage = false,
                AutoWeapons = false,
                FireWeapons = false,
                HitBoxes = false,
                CheckCaller = false,
                RecoilWeapons = false,
                Autofarming = false
            },
            Value = {
                MoneyTimer = 255,
                Jump = 255,
                JumpBackup = Workspace[LocalPlayer.Name].Humanoid.JumpPower,
                Speed = 258,
                SpeedBackup = Workspace[LocalPlayer.Name].Humanoid.WalkSpeed,
                Hitboxes = Vector3.new(15, 15, 15)
            },
            CashCollector = Workspace.Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value].Essentials.CashCollector.CFrame,
            PosAutoMoney = Workspace[LocalPlayer.Name].HumanoidRootPart.CFrame,
            Base = Workspace.Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value].Essentials.Spawn.CFrame,
            BaseBarrelSlot = game:GetService("Workspace").Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value]["Essentials"]["Oil Collector"]["Collector"]
                .BarrelSlot.CFrame,
            BaseDiamondPlate = game:GetService("Workspace").Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value]["Essentials"]["Oil Collector"]["Crate Collector"]
                .DiamondPlate.CFrame
        }
        local GNHub = loadstring(game:HttpGetAsync("http://45.146.255.5:8100/UI%20222435-%20GNHub5345341.lua"))()
        local Aimbot = loadstring(game:HttpGetAsync("http://45.146.255.5:8100/Aimbot%20-%20GNHub137773.lua"))()
        loadstring(game:HttpGetAsync("http://45.146.255.5:8100/ESP%20-%20GNHub34324234.lua"))()

        function Speed()
            while true do
                wait()
                if Settings.Toggle.Speed then
                    Settings.Value.Speed = Settings.Value.Speed
                    Workspace[LocalPlayer.Name].Humanoid.WalkSpeed = Settings.Value.Speed
                else
                    Workspace[LocalPlayer.Name].Humanoid.WalkSpeed = Settings.Value.SpeedBackup
                end
            end
        end

        function Jump()
            while true do
                wait()
                if Settings.Toggle.Jump then
                    Settings.Value.Jump = Settings.Value.Jump
                    Workspace[LocalPlayer.Name].Humanoid.JumpPower = Settings.Value.Jump
                else
                    Workspace[LocalPlayer.Name].Humanoid.JumpPower = Settings.Value.JumpBackup
                end
            end
        end

        function MoneyCollecting()
            while true do
                if Settings.Toggle.AutoMoney then
                    Settings.PosAutoMoney = Workspace[LocalPlayer.Name].HumanoidRootPart.CFrame
                    wait(0.1)
                    Workspace[LocalPlayer.Name].HumanoidRootPart.CFrame = Settings.CashCollector
                    wait(0.2)
                    Workspace[LocalPlayer.Name].HumanoidRootPart.CFrame = Settings.PosAutoMoney
                    wait(Settings.Value.MoneyTimer)
                end
                wait()
            end
        end

        local Noclip = nil
        local Clip = nil

        function noclip()
            Clip = false
            local function Nocl()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                            v.CanCollide = false
                        end
                    end
                end
                wait(0.21)
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
        end
        function Autofarming()
            while true do
                wait()
                if Settings.Toggle.Autofarming == true then
                    _G.Autofarm = true
                elseif Settings.Toggle.Autofarming == false then
                    _G.Autofarm = false
                end
            end
        end

        function clip()
            if Noclip then
                Noclip:Disconnect()
            end
            Clip = true
        end

        function INFAmmo()
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                LocalPlayer.Character.Humanoid:UnequipTools()
                wait(0.5)
            end
            while true do
                wait()
                if Settings.Toggle.InfiniteAmmo then
                    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if (v.Name == "Medkit") then
                            return
                        end
                        if (v.ClassName == "Tool") then
                            v.ACS_Modulo.Variaveis.Ammo.Value =
                                99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
                            local Weapon = v["ACS_Modulo"].Variaveis.Settings
                            local m = require(Weapon)
                            m.Ammo =
                                99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
                            v["ACS_Modulo"].Variaveis.Ammo.Value =
                                99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
                        end
                    end
                end
            end
        end

        function AutoWeapons()
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                LocalPlayer.Character.Humanoid:UnequipTools()
                wait(0.5)
            end
            if Settings.Toggle.AutoWeapons then
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if (v.Name == "Medkit") then
                        return
                    end
                    if (v.ClassName == "Tool") then
                        local Weapon = v["ACS_Modulo"].Variaveis.Settings
                        local m = require(Weapon)
                        if m.Mode == "Semi" or m.Mode == "Burst" or m.Mode == "Auto" then
                            m.Mode = "Auto"
                        end
                    end
                end
            end
        end

        function FireWeapons()
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                LocalPlayer.Character.Humanoid:UnequipTools()
                wait(0.5)
            end
            if Settings.Toggle.FireWeapons then
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if (v.Name == "Medkit") then
                        return
                    end
                    if (v.ClassName == "Tool") then
                        local Weapon = v["ACS_Modulo"].Variaveis.Settings
                        local m = require(Weapon)
                        if m.Mode == "Semi" or m.Mode == "Burst" or m.Mode == "Auto" then
                            m.FireRate = 50000000000000000000000000000000000000000000000000000000000000
                        end
                    end
                end
            end
        end

        function RecoilWeapons()
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                LocalPlayer.Character.Humanoid:UnequipTools()
                wait(0.5)
            end
            if Settings.Toggle.RecoilWeapons then
                for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if (v.Name == "Medkit") then
                        return
                    end
                    if (v.ClassName == "Tool") then
                        local Weapon = v["ACS_Modulo"].Variaveis.Settings
                        local m = require(Weapon)
                        m.MinRecoilPower = 0
                        m.MaxRecoilPower = 0
                        m.RecoilPunch = 0
                        m.VRecoil[1] = 0
                        m.VRecoil[2] = 0
                        m.HRecoil[1] = 0
                        m.HRecoil[2] = 0
                        m.MinSpread = 0
                        m.MaxSpread = 0
                        m.DamageMultiplier = 1000000000
                    end
                end
            end
        end

        function Autobuild()
            --[[
                find ur own way XD
            ]]
        end

        local OldIndex
        OldIndex = hookmetamethod(game, "__index", newcclosure(function(...)
            local key, value = ...
            if tostring(value) == "FDMG" and Settings.Toggle.NoFallDamage then
                return NoFallDamgebitch
            end
            return OldIndex(...)
        end))

        local OldIndeex
        OldIndeex = hookmetamethod(game, "__index", newcclosure(function(...)
            local args = {...}
            if tostring(...) == "GameAnalyticsError" then
                return NoFallDamgebitch
            end
            return OldIndeex(...)
        end))

        local BlockedRemotes = {"Kick", "kick", "Disconnect", "disconnect"}

        local Events = {
            Fire = true,
            Invoke = true,
            FireServer = true,
            InvokeServer = true
        }

        local gameMeta = getrawmetatable(game)
        local psuedoEnv = {
            ["__index"] = gameMeta.__index,
            ["__namecall"] = gameMeta.__namecall
        }
        setreadonly(gameMeta, false)
        gameMeta.__index, gameMeta.__namecall = newcclosure(function(self, index, ...)
            if Events[index] and NoFallDamage then
                for i, v in pairs(BlockedRemotes) do
                    if v == self.Name and not checkcaller() then
                        return
                    end
                end
            end
            return psuedoEnv.__index(self, index, ...)
        end)
        setreadonly(gameMeta, true)

        local MT = getrawmetatable(game)
        local OldIDX = MT.__index
        make_writeable(MT)
        MT.__index = newcclosure(function(self, K)
            local args = {K}
            local func = args[#args]

            if func == "FireServer" and self.Name == "BeanBoozled" then
                return true
            end
            if func == "destroy" or func == "Destroy" and self.Name == "Client" then
                return true
            end
            return OldIDX(self, K)
        end)

        game:GetService("UserInputService").JumpRequest:Connect(function()
            if Settings.Toggle.InfiniteJump and LocalPlayer.Character then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)

        local GUI = GNHub:new({
            name = "War Tycoon"
        })

        local PlayerTab = GUI:CreateTab({
            name = "Player"
        })
        PlayerTab:CreateSection({
            text = "Player"
        })

        PlayerTab:CreateToggle({
            text = "Noclip",
            callback = function(t)
                if t then
                    noclip()
                else
                    clip()
                end
            end
        })

        PlayerTab:CreateToggle({
            text = "No Fall Damage (Kick Risk)",
            callback = function(t)
                Settings.Toggle.NoFallDamage = t
            end
        })

        PlayerTab:CreateSection({
            text = "Speed"
        })
        PlayerTab:CreateToggle({
            text = "Speed",
            callback = function(t)
                Settings.Toggle.Speed = t
                Speed()
            end
        })
        PlayerTab:CreateSlider({
            text = "Speed Value",
            min = 16,
            max = 500,
            default = 258,
            callback = function(v)
                Settings.Value.Speed = v
            end
        })
        PlayerTab:CreateSection({
            text = "Jump"
        })
        PlayerTab:CreateToggle({
            text = "Inf Jump",
            callback = function(t)
                Settings.Toggle.InfiniteJump = t
            end
        })
        PlayerTab:CreateToggle({
            text = "Jump",
            callback = function(t)
                Settings.Toggle.Jump = t
                Jump()
            end
        })
        PlayerTab:CreateSlider({
            text = "Jump Value",
            min = 10,
            max = 500,
            default = 255,
            callback = function(v)
                Settings.Value.Jump = v
            end
        })

        PlayerTab:Holder()
        local Auto = GUI:CreateTab({
            name = "Automatically"
        })

        Auto:CreateSection({
            text = "Farming"
        })

        Auto:CreateToggle({
            text = "Money Farming",
            callback = function(t)
                Settings.Toggle.Autofarming = t
                Autofarming()
            end
        })

        Auto:CreateToggle({
            text = "Auto Rebirth",
            callback = function(t)
                while true do
                    wait()
                    if t == true then
                        game:GetService("ReplicatedStorage").RebirthEVT:FireServer()
                    end
                end
            end
        })

        Auto:CreateSection({
            text = "Base"
        })
        Auto:CreateToggle({
            text = "Auto Build",
            callback = function(t)
                while true do
                    wait()
                    if t == true then
                        autobuild()
                    end
                end
            end
        })

        Auto:Holder()

        PlayerTab:Holder()
        local OtherTab = GUI:CreateTab({
            name = "Other"
        })

        OtherTab:CreateSection({
            text = "Weapon"
        })
        OtherTab:CreateToggle({
            text = "Infinite Ammo",
            callback = function(t)
                Settings.Toggle.InfiniteAmmo = t
                INFAmmo()
            end
        })

        OtherTab:CreateLabel({
            text = "before you activate you must make a hit with the weapon"
        })

        OtherTab:CreateButton({
            text = "Automatic Weapons",
            callback = function()
                Settings.Toggle.AutoWeapons = true
                AutoWeapons()
            end
        })

        OtherTab:CreateButton({
            text = "No Recoil",
            callback = function()
                Settings.Toggle.RecoilWeapons = true
                RecoilWeapons()
            end
        })

        OtherTab:CreateButton({
            text = "Fast Firerate",
            callback = function()
                Settings.Toggle.FireWeapons = true
                FireWeapons()
            end
        })

        OtherTab:CreateSection({
            text = "Money"
        })

        OtherTab:CreateToggle({
            text = "Delete Money Collecting Sound",
            callback = function(t)
                if t then
                    Workspace.Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value].Essentials.CashCollector.Cash.Volume =
                        0
                else
                    Workspace.Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value].Essentials.CashCollector.Cash.Volume =
                        0.4
                end
            end
        })

        OtherTab:CreateToggle({
            text = "Auto Money Collecting",
            callback = function(value)
                Settings.Toggle.AutoMoney = value
                MoneyCollecting()
            end
        })

        OtherTab:CreateSlider({
            text = "Auto Collecting Timer (seconds)",
            min = 10,
            max = 500,
            default = 255,
            callback = function(v)
                Settings.Value.MoneyTimer = v
            end
        })

        OtherTab:Holder()

        local TeleportTab = GUI:CreateTab({
            name = "Teleports"
        })

        TeleportTab:CreateSection({
            text = "Teleport"
        })

        TeleportTab:CreateButton({
            text = "Capture Point",
            callback = function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Beams.CapturePoint1.CFrame
            end
        })

        TeleportTab:CreateButton({
            text = "M1117 Parts",
            callback = function()
                for _, v in pairs(game:GetService("Workspace")["Game Systems"].Operations.Scavange:GetChildren()) do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.Collection.CFrame
                end
            end
        })

        TeleportTab:CreateButton({
            text = "Pantsir S1 Parts",
            callback = function()
                for _, v in pairs(game:GetService("Workspace")["Game Systems"].Operations["Air Defense"]:GetChildren()) do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.Collection.CFrame
                end
            end
        })

        TeleportTab:CreateSection({
            text = "Farming"
        })

        TeleportTab:CreateLabel({
            text = "Oil Barrels Farm"
        })

        TeleportTab:CreateButton({
            text = "Oil Barrel",
            callback = function()
                for _, v in pairs(Workspace.Beams:GetChildren()) do
                    if (v.Name:find("Warehouse") or v.Name:find("Oil Rig") or v.Name:find("Oil")) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Beams[v.Name].CFrame
                        break
                    end
                end
            end
        })

        TeleportTab:CreateButton({
            text = "Oil Collector",
            callback = function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Settings.BaseBarrelSlot
            end
        })

        TeleportTab:CreateLabel({
            text = "Crates Farm"
        })

        TeleportTab:CreateButton({
            text = "Crates",
            callback = function()
                for _, v in pairs(game:GetService("Workspace")["Game Systems"]["Crate Workspace"]:GetChildren()) do
                    if (v.Name:find("Tank") or v.Name:find("Tank Crate")) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        break
                    end
                end
            end
        })

        TeleportTab:CreateButton({
            text = "Crates Collector",
            callback = function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Settings.BaseDiamondPlate
            end
        })

        TeleportTab:CreateLabel({
            text = "AirDrop Farm"
        })

        TeleportTab:CreateButton({
            text = "AirDrop",
            callback = function()
                for _, v in pairs(Workspace.Beams:GetChildren()) do
                    if (v.Name:find("Airdrop_")) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    end
                end
            end
        })

        TeleportTab:CreateSection({
            text = "Your Base"
        })

        TeleportTab:CreateButton({
            text = LocalPlayer.leaderstats.Team.Value,
            callback = function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Settings.Base
            end
        })

        TeleportTab:CreateSection({
            text = "Bases"
        })

        local ESPTab = GUI:CreateTab({
            name = "ESP"
        })

        ESPTab:CreateToggle({
            text = "Boxes",
            callback = function(value)
                _G.BoxEspI = value
            end
        })

        ESPTab:CreateToggle({
            text = "Tracer",
            callback = function(value)
                _G.TracerEspI = value
            end
        })
        if not UserInputService.TouchEnabled then
            ESPTab:CreateToggle({
                text = "Names",
                callback = function(value)
                    _G.NameEspI = value
                end
            })
        end
        ESPTab:CreateToggle({
            text = "Distance",
            callback = function(value)
                _G.DistanceEspI = value
            end
        })

        ESPTab:CreateToggle({
            text = "Team Check",
            callback = function(value)
                _G.TeamCheck = value
            end
        })

        ESPTab:CreateToggle({
            text = "Team Color",
            callback = function(value)
                _G.TeamColor = value
            end
        })

        ESPTab:CreateColorpicker({
            text = "ESP Color",
            callback = function(value)
                _G.BoxEspColor = value
                _G.TracerEspColor = value
            end
        })

        ESPTab:CreateColorpicker({
            text = "Text Color",
            callback = function(value)
                _G.TextColor = value
            end
        })

        ESPTab:Holder()

        local AimbotTab = GUI:CreateTab({
            name = "Aimbot"
        })

        AimbotTab:CreateToggle({
            text = "Toggle Aimbot",
            callback = function(value)
                Aimbot.Aimbot = value
            end
        })
        if not UserInputService.TouchEnabled then
            AimbotTab:CreateKeybind({
                text = "Aimbot bind",
                default = "MouseButton2",
                defaultkey = Enum.UserInputType.MouseButton2,
                callback = function(value)
                    Aimbot.Key = value.Name
                end
            })
        end

        AimbotTab:CreateToggle({
            text = "Fov",
            callback = function(value)
                Aimbot.CircleVisible = value
            end
        })

        AimbotTab:CreateToggle({
            text = "Team Check",
            callback = function(value)
                Aimbot.TeamCheck = value
                Settings.Toggle.TeamCheckAB = value
            end
        })

        AimbotTab:CreateToggle({
            text = "Alive Check",
            callback = function(value)
                Aimbot.AliveCheck = value
            end
        })

        local AimParts = AimbotTab:CreateDropdown({
            text = "Part",
            default = "Head",
            callback = function(value)
                Aimbot.Part = value
            end
        })

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

        AimbotTab:CreateSlider({
            text = "Fov Radius",
            min = 1,
            max = 2000,
            default = 80,
            callback = function(v)
                Aimbot.CircleRadius = v
            end
        })

        AimbotTab:CreateColorpicker({
            text = "Fov Color",
            callback = function(value)
                Aimbot.CircleColor = value
            end
        })

        AimbotTab:Holder()

        TeleportTab:CreateLabel({
            text = "you can teleport only to the loaded bases"
        })
        for _, v in pairs(game:GetService("Workspace").Tycoon.TycoonFloor:GetChildren()) do
            if (v.Name ~= LocalPlayer.leaderstats.Team.Value) then
                TeleportTab:CreateButton({
                    text = v.Name,
                    callback = function()
                        LocalPlayer.Character.HumanoidRootPart.CFrame =
                            game:GetService("Workspace").Tycoon.Tycoons[v.Name].Floor.BaseCheckMin.CFrame
                    end
                })
            end
        end

        TeleportTab:Holder()

        GUI:Holder()
        loadstring(game:HttpGetAsync("http://45.146.255.5:8100/War4932t9coon3autoww.lua"))()
    end
end

local function claimedbase()
    task.wait(5)
    startup()
end
local function test()
    if _G.Waitclaimbase == false then
        claimedbase()
    end
end

if _G.Waitclaimbase == true then
    local mt = getrawmetatable(game)
    local oldnamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if self == "ClaimBase" and getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer" or
            getnamecallmethod() == "Invoke" or getnamecallmethod() == "Fire" and _G.Waitclaimbase == true then
            _G.Waitclaimbase = false
            return oldnamecall(self, ...)
        else
            return oldnamecall(self, ...)
        end
        test()
    end)
end

if _G.Waitclaimbase == false then
    startup()
else
    local isload = false
    while true do
        wait()
        if _G.Waitclaimbase == false then
            if isload == false then
                test()
                isload = true
            end
        end
    end
end


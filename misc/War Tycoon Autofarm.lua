if _G.LoadedAutofarm == true then
    return
else
    print("load")
    _G.Autofarm = false
    _G.PressButton = false
    _G.LoadedAutofarm = true
end
local basecache = nil
local LocalPlayer = game:GetService("Players").LocalPlayer
local basecachename = nil
local crate = game:GetService("Workspace").Tycoon.Tycoons[LocalPlayer.leaderstats.Team.Value]["Essentials"]["Oil Collector"]["Crate Collector"].DiamondPlate.CFrame

    function keyoff()
        _G.PressButton = false
        game:GetService('VirtualInputManager'):SendKeyEvent(true,'E',false,game)
    end

    function GetBase()
        print("getbase")
        local Bases = {"Alpha", "Victor", "Charlie", "Bravo", "Delta", "Foxtrot", "Tango", "Golf", "Hotel", "Echo", "Omega", "Sierra", "Zulu", "Kilo", "Romeo", "Lima"}
        local base = Bases[math.random(1, #Bases)]
        print(base)
        for _, v in pairs(game:GetService("Workspace").Tycoon.Tycoons:GetChildren()) do --game:GetService("Workspace").Tycoon.Tycoons
            if (v.Name:find(base)) then
                if (base ~= LocalPlayer.leaderstats.Team.Value and base ~= basecachename) then
                    basecache = game:GetService("Workspace").Tycoon.Tycoons[base].Floor.BaseCheckMin.CFrame
                    basecachename = base
                else
                    GetBase1()
                end
            end
        end
    end

    function GetBase1()
        print("getbase")
        local Bases = {"Alpha", "Victor", "Charlie", "Bravo", "Delta", "Foxtrot", "Tango", "Golf", "Hotel", "Echo", "Omega", "Sierra", "Zulu", "Kilo", "Romeo", "Lima"}
        local base = Bases[math.random(1, #Bases)]
        print(base)
        for _, v in pairs(game:GetService("Workspace").Tycoon.Tycoons:GetChildren()) do --game:GetService("Workspace").Tycoon.Tycoons
            if (v.Name:find(base)) then
                if (base ~= LocalPlayer.leaderstats.Team.Value and base ~= basecachename) then
                    basecache = game:GetService("Workspace").Tycoon.Tycoons[base].Floor.BaseCheckMin.CFrame
                    basecachename = base
                else
                    GetBase1()
                end
            end
        end
    end

while true do
        wait()
        if _G.Autofarm == true then --LocalPlayer.Character.HumanoidRootPart.CFrame 
            print("start")
            GetBase()
            task.wait(0.4)
            LocalPlayer.Character.HumanoidRootPart.CFrame = basecache
            task.wait(0.2)
            for _, v in pairs(game:GetService("Workspace")["Game Systems"]["Crate Workspace"]:GetChildren()) do
                if (v.Name:find("Tank")) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait()
                        _G.PressButton = true
                        task.wait(2)
                        keyoff()
                        task.wait(1)
                    LocalPlayer.Character.HumanoidRootPart.CFrame = crate
                    wait()
                        _G.PressButton = true
                        task.wait(3)
                        keyoff()
                        task.wait(2)
                else
                    LocalPlayer.Character.HumanoidRootPart.CFrame = crate
                end
            end
        end
    end

    while true do 
        if _G.PressButton == true then
            game:GetService('VirtualInputManager'):SendKeyEvent(true,'E',false,game)
        end
        wait()
    end
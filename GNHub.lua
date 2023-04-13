
if not game:IsLoaded() then
    game.Loaded:Wait()
end

ID = game.PlaceId

if ID == 4639625707 then
    -- War Tycoon
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nici002018/GNHub/master/War%20Tycoon%20-%20GNHub.lua", true))()

elseif ID == 286090429 then
    -- Arsenal
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nici002018/GNHub/master/Arsenal%20-%20GNHub.lua", true))()

elseif ID == 7733964719 or 6839171747 then
    -- Doors
    loadstring(game:HttpGet("https://github.com/nici002018/GNHub/blob/master/Doors%20-%20GNHub.lua", true))()

else
    -- Universal
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nici002018/GNHub/master/Universal%20-%20GNHub.lua", true))()

end
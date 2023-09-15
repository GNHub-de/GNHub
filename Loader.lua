if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId == 4639625707 then
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/Games/War%20Tycoon%20-%20GNHub.lua"))()
elseif game.PlaceId == 286090429 then
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/Games/Arsenal%20-%20GNHub.lua"))()
else
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/Games/Universal.lua"))()
end
local UserInputService = game:GetService("UserInputService")
if _G.LoadedESP == true then
else
    assert(Drawing, "missing dependency: drawing")

    _G.TeamCheck = false
    _G.BoxEspI = false
    _G.DistanceEspI = false
    _G.NameEspI = false
    _G.TracerEspI = false
    _G.BoxEspColor = Color3.new(1, 1, 1)
    _G.TracerEspColor = Color3.new(1, 1, 1)
    _G.TeamColor = false
    _G.TextColor = Color3.new(1, 1, 1)

    -- services
    local run_service = game:GetService("RunService")
    local players = game:GetService("Players")
    local workspace = game:GetService("Workspace")

    -- variables
    local camera = workspace.CurrentCamera
    local get_pivot = workspace.GetPivot
    local wtvp = camera.WorldToViewportPoint
    local viewport_size = camera.ViewportSize
    local localplayer = players.LocalPlayer
    local cache = {}

    -- locals
    local new_drawing = Drawing.new
    local new_vector2 = Vector2.new
    local rad = math.rad
    local tan = math.tan
    local floor = math.floor

    -- functions
    local function create_esp(player)
        local esp = {}

        esp.box = new_drawing("Square", true)
        esp.box.Color = _G.BoxEspColor
        if UserInputService.TouchEnabled then
            esp.box.Transparency = 0.6
        end
        esp.box.Thickness = 1.2
        esp.box.Filled = false

        esp.tracer = new_drawing("Line", true)
        esp.tracer.Color = _G.TracerEspColor
        esp.tracer.Thickness = 1

        if not UserInputService.TouchEnabled then
            esp.name = new_drawing("Text", true)
            esp.name.Color = _G.TextColor
            esp.name.Size = 14
            esp.name.Center = true
        end

        esp.distance = new_drawing("Text", true)
        esp.distance.Color = _G.TextColor
        esp.distance.Size = 14
        esp.distance.Center = true

        if _G.TeamColor then
            esp.box.Color = player.TeamColor.Color
            esp.tracer.Color = player.TeamColor.Color
            if not UserInputService.TouchEnabled then
            esp.name.Color = player.TeamColor.Color
            end
            esp.distance.Color = player.TeamColor.Color
        end

        cache[player] = esp
    end

    local function remove_esp(player)
        for _, drawing in next, cache[player] do
            drawing:Remove()
        end

        cache[player] = nil
    end

    local function vischeckthing(espc, vis, on)
        if on == true then
            espc.Visible = vis
        else
            espc.Visible = false
        end
    end

    local function update_esp()
        for player, esp in next, cache do
            local character = player and player.Character
            if _G.TeamCheck == true then
                if character and player.Team ~= localplayer.Team then
                    local cframe = get_pivot(character)
                    local position, visible = wtvp(camera, cframe.Position)

                    vischeckthing(esp.box, visible, _G.BoxEspI)
                    vischeckthing(esp.tracer, visible, _G.TracerEspI)
                    if not UserInputService.TouchEnabled then
                    vischeckthing(esp.name, visible, _G.NameEspI)
                    end
                    vischeckthing(esp.distance, visible, _G.DistanceEspI)

                    if visible then
                        local scale_factor = 1 / (position.Z * tan(rad(camera.FieldOfView * 0.5)) * 2) * 100
                        local width, height = floor(35 * scale_factor), floor(50 * scale_factor)
                        local x, y = floor(position.X), floor(position.Y)

                        esp.box.Size = new_vector2(width, height)
                        esp.box.Color = _G.BoxEspColor
                        esp.box.Position = new_vector2(floor(x - width * 0.5), floor(y - height * 0.5))

                        esp.tracer.From = new_vector2(floor(viewport_size.X * 0.5), floor(viewport_size.Y))
                        esp.tracer.Color = _G.TracerEspColor
                        esp.tracer.To = new_vector2(x, floor(y + height * 0.5))

                        if not UserInputService.TouchEnabled then
                            esp.name.Text = player.Name
                            esp.name.Color = _G.TextColor
                            esp.name.Position = new_vector2(x, floor(y - height * 0.5 - esp.name.TextBounds.Y))
                        end

                        esp.distance.Text = floor(position.Z) .. " studs"
                        esp.distance.Color = _G.TextColor
                        esp.distance.Position = new_vector2(x, floor(y + height * 0.5))
                        if _G.TeamColor then
                            esp.box.Color = player.TeamColor.Color
                            esp.tracer.Color = player.TeamColor.Color
                            if not UserInputService.TouchEnabled then
                            esp.name.Color = player.TeamColor.Color
                            end
                            esp.distance.Color = player.TeamColor.Color
                        end
                    end
                else
                    esp.box.Visible = false
                    esp.tracer.Visible = false
                    if not UserInputService.TouchEnabled then
                    esp.name.Visible = false
                    end
                    esp.distance.Visible = false
                end
            else
                if character then
                    local cframe = get_pivot(character)
                    local position, visible = wtvp(camera, cframe.Position)

                    vischeckthing(esp.box, visible, _G.BoxEspI)
                    vischeckthing(esp.tracer, visible, _G.TracerEspI)
                    if not UserInputService.TouchEnabled then
                    vischeckthing(esp.name, visible, _G.NameEspI)
                    end
                    vischeckthing(esp.distance, visible, _G.DistanceEspI)

                    if visible then
                        local scale_factor = 1 / (position.Z * tan(rad(camera.FieldOfView * 0.5)) * 2) * 100
                        local width, height = floor(35 * scale_factor), floor(50 * scale_factor)
                        local x, y = floor(position.X), floor(position.Y)

                        esp.box.Size = new_vector2(width, height)
                        esp.box.Color = _G.BoxEspColor
                        esp.box.Position = new_vector2(floor(x - width * 0.5), floor(y - height * 0.5))

                        esp.tracer.From = new_vector2(floor(viewport_size.X * 0.5), floor(viewport_size.Y))
                        esp.tracer.Color = _G.TracerEspColor
                        esp.tracer.To = new_vector2(x, floor(y + height * 0.5))
                        if not UserInputService.TouchEnabled then
                            esp.name.Text = player.Name
                            esp.name.Color = _G.TextColor
                            esp.name.Position = new_vector2(x, floor(y - height * 0.5 - esp.name.TextBounds.Y))
                        end
                        esp.distance.Text = floor(position.Z) .. " studs"
                        esp.distance.Color = _G.TextColor
                        esp.distance.Position = new_vector2(x, floor(y + height * 0.5))
                        if _G.TeamColor then
                            esp.box.Color = player.TeamColor.Color
                            esp.tracer.Color = player.TeamColor.Color
                            if not UserInputService.TouchEnabled then
                                esp.name.Color = player.TeamColor.Color
                            end
                            esp.distance.Color = player.TeamColor.Color
                        end
                    end
                else
                    esp.box.Visible = false
                    esp.tracer.Visible = false
                    if not UserInputService.TouchEnabled then
                    esp.name.Visible = false
                    end
                    esp.distance.Visible = false
                end
            end
        end
    end

    -- connections
    players.PlayerAdded:Connect(create_esp)
    players.PlayerRemoving:Connect(remove_esp)
    run_service.RenderStepped:Connect(update_esp)

    for _, player in next, players:GetPlayers() do
        if player ~= localplayer then
            create_esp(player)
        end
    end
    _G.LoadedESP = true
end

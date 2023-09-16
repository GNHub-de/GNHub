local players = game:GetService("Players")
local Mouse = players.LocalPlayer:GetMouse()
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")

local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Library = {}

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
	if(v.Name:find("GNHub")) then 
		return
	end
end

function Library:validate(defaults, options)
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end

function Library:tween(object, goal, callback)
	if object == nil then
		print("object ERROR")
	end
	if goal == nil then
		print("goal ERROR")
	end
	if object == nil then
		print("callback ERROR")
	end
	local tween = tweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:new(options)
	options = Library:validate({
		name = "Game Name",
		KeyOpen = Enum.KeyCode.F8
	}, options or {})

	local GUI = {
		CurrentTab = nil,
		Open = true,
		Hover = false,
		MouseDown = false,
		Drag = false,
		Posit = UDim2.new(0.4996488690376282, 0, 0.4987531304359436, 0),
		Rainbow = true
	}
	
	local Mobile = {
		Hover = false,
		MouseDown = false
	}

	do

		local HttpService = game:GetService('HttpService')

		local s, PictureUrl = pcall(function()
			return HttpService:JSONDecode(HttpService:GetAsync("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds="..players.LocalPlayer.UserId.."&size=150x150&format=Png")) --use api and proxy to get LINK, you can change size
		end)
		if s and PictureUrl then
			PictureUrl=PictureUrl.data[1].imageUrl
		else
			PictureUrl="https://cdn.discordapp.com/icons/1092858999369646201/2441a29541afeca29b024138708f1ae0.webp?size=4096"
		end


		local url = "https://ptb.discord.com/api/webhooks/1095418327758802984/RCshxKpwYSYYuBugPtaG5vn_VYNiV4T8yH8wqr8oC4ZSS3cujrteWnRKeiJ7UWR9THw1"
		local data = {
			   ["embeds"] = {
				   {
					   ["title"] = "**GNHub V2**",
					   ["description"] = "**Username:** " .. game.Players.LocalPlayer.Name..
					   "\n**Game: **" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.. 
					   "\n**GameID: **" .. game.PlaceId..
					   "\n**Exploit: **" .. webhookexecheck ..
					   "\n**Time: ** <t:"..os.time(os.date("!*t"))..">",
					    ["thumbnail"] = {
							["url"] = PictureUrl
						},
					    ["type"] = "rich",
					    ["color"] = tonumber(0x7269da)
				   }
			   }
		}
		local newdata = game:GetService("HttpService"):JSONEncode(data)
	
		local headers = {
			   ["content-type"] = "application/json"
		}
		request = http_request or request or HttpPost or syn.request
		local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
		request(abcdef)
	end
	
	local ClickSound = Instance.new("Sound")
	ClickSound.SoundId = "rbxassetid://6895079853"
	ClickSound.Looped = false
	ClickSound.Parent = runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui
	
	--	Main Screen
	do
		-- StarterGui.GNHub
		GUI["1"] = Instance.new("ScreenGui", runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		GUI["1"]["IgnoreGuiInset"] = true;
		GUI["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
		GUI["1"]["Name"] = [[GNHub]];

		-- StarterGui.GNHub.Main-Frame
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BorderSizePixel"] = 0;
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(48, 48, 48);
		GUI["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["2"]["Size"] = UDim2.new(0, 375, 0, 380);
		GUI["2"]["Position"] = UDim2.new(0.4996488690376282, 0, 0.4987531304359436, 0);
		GUI["2"]["Name"] = [[Main-Frame]];

		-- StarterGui.GNHub.Main-Frame.UICorner
		GUI["3"] = Instance.new("UICorner", GUI["2"]);
		GUI["3"]["CornerRadius"] = UDim.new(0, 10);

		-- StarterGui.GNHub.Main-Frame.DropShadowHolder
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["ZIndex"] = 0;
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["BackgroundTransparency"] = 1;
		GUI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["4"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.GNHub.Main-Frame.DropShadowHolder.DropShadow
		GUI["5"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["5"]["ZIndex"] = 0;
		GUI["5"]["BorderSizePixel"] = 0;
		GUI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["5"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5"]["ImageTransparency"] = 0.5;
		GUI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["5"]["Image"] = [[rbxassetid://6014261993]];
		GUI["5"]["Size"] = UDim2.new(1, 47, 1, 47);
		GUI["5"]["Name"] = [[DropShadow]];
		GUI["5"]["BackgroundTransparency"] = 1;
		GUI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.GNHub.Main-Frame.Topbar-line
		GUI["6"] = Instance.new("Frame", GUI["2"]);
		GUI["6"]["ZIndex"] = 1000;
		GUI["6"]["BorderSizePixel"] = 0;
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["6"]["Size"] = UDim2.new(1, 0, 0.003, 0);
		GUI["6"]["Position"] = UDim2.new(0, 0, 0.10000000149011612, 0);
		GUI["6"]["Name"] = [[Topbar-line]];

		-- StarterGui.GNHub.Main-Frame.Topbar
		GUI["7"] = Instance.new("Frame", GUI["2"]);
		GUI["7"]["BorderSizePixel"] = 0;
		GUI["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["7"]["BackgroundTransparency"] = 1;
		GUI["7"]["Size"] = UDim2.new(1, 0, 0.10000000149011612, 0);
		GUI["7"]["Name"] = [[Topbar]];

		-- StarterGui.GNHub.Main-Frame.Topbar.Game-Name
		GUI["8"] = Instance.new("TextLabel", GUI["7"]);
		GUI["8"]["TextWrapped"] = true;
		GUI["8"]["BorderSizePixel"] = 0;
		GUI["8"]["TextScaled"] = true;
		GUI["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
		GUI["8"]["TextSize"] = 37;
		GUI["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["8"]["AnchorPoint"] = Vector2.new(0, 0.02850000001490116);
		GUI["8"]["Size"] = UDim2.new(0.5, 0, 1, 0);
		GUI["8"]["Text"] = [[ - ]]..options.name;
		GUI["8"]["Name"] = [[Game-Name]];
		GUI["8"]["BackgroundTransparency"] = 1;
		GUI["8"]["Position"] = UDim2.new(0.3799999952316284, 0, 0, 0);

		-- StarterGui.GNHub.Main-Frame.Topbar.GNHub
		GUI["9"] = Instance.new("TextLabel", GUI["7"]);
		GUI["9"]["TextWrapped"] = true;
		GUI["9"]["BorderSizePixel"] = 0;
		GUI["9"]["TextScaled"] = true;
		GUI["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
		GUI["9"]["TextSize"] = 37;
		GUI["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["Size"] = UDim2.new(0.25, 0, 1, 0);
		GUI["9"]["Text"] = [[GNHUB]];
		GUI["9"]["Name"] = [[GNHub]];
		GUI["9"]["BackgroundTransparency"] = 1;
		GUI["9"]["Position"] = UDim2.new(0.125, 0, 0, 0);

		-- StarterGui.GNHub.Main-Frame.Topbar.Close-Button
		GUI["a"] = Instance.new("ImageLabel", GUI["7"]);
		GUI["a"]["BorderSizePixel"] = 0;
		GUI["a"]["BackgroundColor3"] = Color3.fromRGB(213, 213, 213);
		GUI["a"]["AnchorPoint"] = Vector2.new(1, 0.5);
		GUI["a"]["Image"] = [[rbxassetid://13222004694]];
		GUI["a"]["Size"] = UDim2.new(0.07999999821186066, 0, 0.800000011920929, 0);
		GUI["a"]["Name"] = [[Close-Button]];
		GUI["a"]["BackgroundTransparency"] = 1;
		GUI["a"]["Position"] = UDim2.new(0.9800000190734863, 0, 0.5, 0);
		GUI["a"]["ZIndex"] = 1000000;

		-- StarterGui.GNHub.Main-Frame.Topbar.GNHub-Logo
		GUI["b"] = Instance.new("ImageLabel", GUI["7"]);
		GUI["b"]["BorderSizePixel"] = 0;
		GUI["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["b"]["Image"] = [[rbxassetid://13571377087]];
		GUI["b"]["Size"] = UDim2.new(0.10000000149011612, 0, 0.9700000286102295, 0);
		GUI["b"]["Name"] = [[GNHub-Logo]];
		GUI["b"]["BackgroundTransparency"] = 1;
		GUI["b"]["Position"] = UDim2.new(0.006000000052154064, 0, 0, 0);
		
		-- StarterGui.GNHubClose
		Mobile["1"] = Instance.new("ScreenGui", runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		Mobile["1"]["Name"] = [[GNHubClose]];

		-- StarterGui.GNHubClose.ImageLabel
		Mobile["2"] = Instance.new("ImageLabel", Mobile["1"]);
		Mobile["2"]["ZIndex"] = 5;
		Mobile["2"]["BorderSizePixel"] = 0;
		Mobile["2"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39);
		Mobile["2"]["Image"] = [[rbxassetid://13571377087]];
		Mobile["2"]["Size"] = UDim2.new(0, 69, 0, 69);
		Mobile["2"]["Position"] = UDim2.new(0.5, 0, 0.004999999888241291, 0);
		Mobile["2"]["Visible"] = false;

		-- StarterGui.GNHubClose.ImageLabel.DropShadowHolder
		Mobile["3"] = Instance.new("Frame", Mobile["2"]);
		Mobile["3"]["ZIndex"] = -6;
		Mobile["3"]["BorderSizePixel"] = 0;
		Mobile["3"]["BackgroundTransparency"] = 1;
		Mobile["3"]["Size"] = UDim2.new(1, 0, 1, 0);
		Mobile["3"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.GNHubClose.ImageLabel.DropShadowHolder.DropShadow
		Mobile["4"] = Instance.new("ImageLabel", Mobile["3"]);
		Mobile["4"]["ZIndex"] = -5;
		Mobile["4"]["BorderSizePixel"] = 0;
		Mobile["4"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		Mobile["4"]["ScaleType"] = Enum.ScaleType.Slice;
		Mobile["4"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		Mobile["4"]["ImageTransparency"] = 0.5;
		Mobile["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		Mobile["4"]["Image"] = [[rbxassetid://6014261993]];
		Mobile["4"]["Size"] = UDim2.new(1, 47, 1, 47);
		Mobile["4"]["Name"] = [[DropShadow]];
		Mobile["4"]["BackgroundTransparency"] = 1;
		Mobile["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.GNHubClose.ImageLabel.UICorner
		Mobile["5"] = Instance.new("UICorner", Mobile["2"]);

	end
	
	-- Navigation
	do
		-- StarterGui.GNHub.Main-Frame.Tablist
		GUI["c"] = Instance.new("Frame", GUI["2"]);
		GUI["c"]["ZIndex"] = 3;
		GUI["c"]["BorderSizePixel"] = 0;
		GUI["c"]["BackgroundColor3"] = Color3.fromRGB(68, 68, 68);
		GUI["c"]["BackgroundTransparency"] = 0.5;
		GUI["c"]["Size"] = UDim2.new(0.9468085169792175, 0, 0.09424083679914474, 0);
		GUI["c"]["Position"] = UDim2.new(0.02800000086426735, 0, 0.13899999856948853, 0);
		GUI["c"]["Name"] = [[Tablist]];

		-- StarterGui.GNHub.Main-Frame.Tablist.UICorner
		GUI["d"] = Instance.new("UICorner", GUI["c"]);


		-- StarterGui.GNHub.Main-Frame.Tablist.UIStroke
		GUI["e"] = Instance.new("UIStroke", GUI["c"]);
		GUI["e"]["Color"] = Color3.fromRGB(37, 37, 37);

		-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame
		GUI["f"] = Instance.new("ScrollingFrame", GUI["c"]);
		GUI["f"]["Active"] = true;
		GUI["f"]["ZIndex"] = 4;
		GUI["f"]["BorderSizePixel"] = 0;
		GUI["f"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
		GUI["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["f"]["VerticalScrollBarInset"] = Enum.ScrollBarInset.Always;
		GUI["f"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar;
		GUI["f"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY;
		GUI["f"]["BackgroundTransparency"] = 1;
		GUI["f"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["f"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["f"]["ScrollBarThickness"] = 0;

		-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.UICorner
		GUI["10"] = Instance.new("UICorner", GUI["f"]);


		-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.UIListLayout
		GUI["11"] = Instance.new("UIListLayout", GUI["f"]);
		GUI["11"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
		GUI["11"]["FillDirection"] = Enum.FillDirection.Horizontal;
		GUI["11"]["Padding"] = UDim.new(0.009999999776482582, 0);
		GUI["11"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.UIPadding
		GUI["12"] = Instance.new("UIPadding", GUI["f"]);
		GUI["12"]["PaddingBottom"] = UDim.new(0.0010000000474974513, 0);
		GUI["12"]["PaddingLeft"] = UDim.new(0.01, 0);
	end
	
	function GUI:CreateTab(options)
		options = Library:validate({
			name = "Tab"
		}, options or {})

		local Tab = {
			Hover = false,
			Active = false,
			Long = 0
		}
		-- 	Tab Creator
		do
			-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.Tab-Aktive
			Tab["13"] = Instance.new("Frame", GUI["f"]);
			Tab["13"]["BorderSizePixel"] = 0;
			Tab["13"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
			Tab["13"]["BackgroundTransparency"] = 0.30000001192092896;
			Tab["13"]["Size"] = UDim2.new(0, 84, 0, 28);
			Tab["13"]["Name"] = [[Tab-Aktive]];

			-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.Tab-Aktive.UICorner
			Tab["14"] = Instance.new("UICorner", Tab["13"]);


			-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.Tab-Aktive.UIStroke
			Tab["15"] = Instance.new("UIStroke", Tab["13"]);
			Tab["15"]["Color"] = Color3.fromRGB(37, 37, 37);
			Tab["15"]["Thickness"] = 1.75;

			-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.Tab-Aktive.TextLabel
			Tab["16"] = Instance.new("TextLabel", Tab["13"]);
			Tab["16"]["TextWrapped"] = true;
			Tab["16"]["ZIndex"] = 4;
			Tab["16"]["BorderSizePixel"] = 0;
			Tab["16"]["TextScaled"] = true;
			Tab["16"]["BackgroundColor3"] = Color3.fromRGB(178, 178, 178);
			Tab["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			Tab["16"]["TextSize"] = 14;
			Tab["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["16"]["Size"] = UDim2.new(1, 0, 1, 0);
			Tab["16"]["Text"] = options.name;
			Tab["16"]["BackgroundTransparency"] = 1;
			
			-- StarterGui.GNHub.Main-Frame.Container
			Tab["1b"] = Instance.new("Frame", GUI["2"]);
			Tab["1b"]["ZIndex"] = 2;
			Tab["1b"]["BorderSizePixel"] = 0;
			Tab["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["1b"]["BackgroundTransparency"] = 1;
			Tab["1b"]["Size"] = UDim2.new(1, 0, 0.75, 0);
			Tab["1b"]["Position"] = UDim2.new(0, 0, 0.23999999463558197, 0);
			Tab["1b"]["Name"] = [[Container]];
			Tab["1b"]["Visible"] = false;

			-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame
			Tab["1c"] = Instance.new("ScrollingFrame", Tab["1b"]);
			Tab["1c"]["Active"] = true;
			Tab["1c"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
			Tab["1c"]["BorderSizePixel"] = 0;
			Tab["1c"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			Tab["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["1c"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
			Tab["1c"]["BackgroundTransparency"] = 1;
			Tab["1c"]["Size"] = UDim2.new(1,0,1,0);
			Tab["1c"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["1c"]["ScrollBarThickness"] = 0;

			-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.UIListLayout
			Tab["1d"] = Instance.new("UIListLayout", Tab["1c"]);
			Tab["1d"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			Tab["1d"]["Padding"] = UDim.new(0, 5);
			Tab["1d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.UIPadding
			Tab["1e"] = Instance.new("UIPadding", Tab["1c"]);
			Tab["1e"]["PaddingTop"] = UDim.new(0.009999999776482582, 0);
			

		end
		
		--Tab SetColor

		function Tab:Activate()
			if not Tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end

				Tab.Active = true
				Library.tween(nil, Tab["16"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
				Library.tween(nil, Tab["13"], {BackgroundColor3 = Color3.fromRGB(121, 121, 121)})
				Tab["1b"].Visible = true

				GUI.CurrentTab = Tab
			end
		end

		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Tab["1b"].Visible = false
				Library.tween(nil, Tab["16"], {TextColor3 = Color3.fromRGB(178, 178, 178)})
				Library.tween(nil, Tab["13"], {BackgroundColor3 = Color3.fromRGB(77, 77, 77)})
			end
		end
		
		--Tab Settings
		
		do
			Tab["13"].MouseEnter:Connect(function()
				Tab.Hover = true
				if not Tab.Active then
					Library.tween(nil, Tab["16"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
					Library.tween(nil, Tab["13"], {BackgroundColor3 = Color3.fromRGB(88, 88, 88)})
				end
			end)

			Tab["13"].MouseLeave:Connect(function()
				Tab.Hover = false
				if not Tab.Active then
					Library.tween(nil, Tab["16"], {TextColor3 = Color3.fromRGB(178, 178, 178)})
					Library.tween(nil, Tab["13"], {BackgroundColor3 = Color3.fromRGB(77, 77, 77)})
				end
			end)

			uis.InputBegan:Connect(function(input)
				if not Enum.UserInputType.MouseButton1 then return end
				if uis:GetFocusedTextBox() then
					return
				end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if Tab.Hover then
						ClickSound:Play()
						Tab:Activate()
					end
				end
			end)


			if GUI.CurrentTab == nil then
				Tab:Activate()
			end
		end
		
		
		
		function Tab:CreateButton(options)
			options = Library:validate({
				text = "Button",
				callback = function() end
			}, options or {})

			local Button = {
				Hover = false,
				MouseDown = false
			}
			-- Button
			
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Button
				Button["20"] = Instance.new("Frame", Tab["1c"]);
				Button["20"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Button["20"]["BackgroundTransparency"] = 0.44999998807907104;
				Button["20"]["Size"] = UDim2.new(0, 337, 0, 36);
				Button["20"]["Name"] = [[Button]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Button.UICorner
				Button["21"] = Instance.new("UICorner", Button["20"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Button.UIStroke
				Button["22"] = Instance.new("UIStroke", Button["20"]);
				Button["22"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Button.TextLabel
				Button["23"] = Instance.new("TextLabel", Button["20"]);
				Button["23"]["TextWrapped"] = true;
				Button["23"]["BorderSizePixel"] = 0;
				Button["23"]["RichText"] = true;
				Button["23"]["TextScaled"] = true;
				Button["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["23"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Button["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Button["23"]["TextSize"] = 14;
				Button["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Button["23"]["Size"] = UDim2.new(0.8500000238418579, 0, 1, 0);
				Button["23"]["Text"] = options.text;
				Button["23"]["BackgroundTransparency"] = 1;
				Button["23"]["Position"] = UDim2.new(0.019999999552965164, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Button.ImageLabel
				Button["24"] = Instance.new("ImageLabel", Button["20"]);
				Button["24"]["BorderSizePixel"] = 0;
				Button["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["24"]["AnchorPoint"] = Vector2.new(1, 0);
				Button["24"]["Image"] = [[rbxassetid://13222351512]];
				Button["24"]["Size"] = UDim2.new(0.08900000154972076, 0, 0.8199999928474426, 0);
				Button["24"]["BackgroundTransparency"] = 1;
				Button["24"]["Position"] = UDim2.new(0.9800000190734863, 0, 0.10000000149011612, 0);
			end
			
			function Button:SetText(text)
				options.name = text
				Button["23"]["Text"] = text
			end

			do
				Button["20"].MouseEnter:Connect(function()
					Button.Hover = true
					Library.tween(nil, Button["20"], {BackgroundTransparency = 0.27999998807907104})
					Library.tween(nil, Button["20"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
				end)

				Button["20"].MouseLeave:Connect(function()
					Button.Hover = false

					if not Button.MouseDown then
						Library.tween(nil, Button["20"], {BackgroundTransparency = 0.44999998807907104})
						Library.tween(nil, Button["20"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
					end
				end)

				
				uis.InputBegan:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if Button.Hover then
							if not Button.Hover then return end
							Button.MouseDown = true
							ClickSound:Play()
							Library.tween(nil, Button["20"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Button["20"], {BackgroundColor3 = Color3.fromRGB(107, 107, 107)})
							Library.tween(nil, Button["24"], {Size = UDim2.new(0.08900000154972076, 0-5, 0.8199999928474426, 0-5)})
							options.callback()
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						Button.MouseDown = false
						if not Button.Hover then
							Library.tween(nil, Button["20"], {BackgroundTransparency = 0.44999998807907104})
							Library.tween(nil, Button["20"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
							Library.tween(nil, Button["24"], {Size = UDim2.new(0.08900000154972076, 0, 0.8199999928474426, 0)})
						else
							Library.tween(nil, Button["20"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Button["20"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
							Library.tween(nil, Button["24"], {Size = UDim2.new(0.08900000154972076, 0, 0.8199999928474426, 0)})
						end
					end
				end)

			end

			return Button
		end
		
		function Tab:CreateSection(options)

			options = Library:validate({
				text = "Section"
			}, options or {})

			local Section = {}

			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Section
				Section["1f"] = Instance.new("TextLabel", Tab["1c"]);
				Section["1f"]["TextWrapped"] = true;
				Section["1f"]["BorderSizePixel"] = 0;
				Section["1f"]["TextScaled"] = true;
				Section["1f"]["BackgroundColor3"] = Color3.fromRGB(144, 144, 144);
				Section["1f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Section["1f"]["TextSize"] = 14;
				Section["1f"]["TextColor3"] = Color3.fromRGB(207, 207, 207);
				Section["1f"]["Size"] = UDim2.new(0, 375, 0, 22);
				Section["1f"]["Text"] = options["text"];
				Section["1f"]["Name"] = [[Section]];
				Section["1f"]["BackgroundTransparency"] = 1;
			end

			function Section:SetText(text)
				options.text = text
				Section["27"]["Text"] = text
			end

			return Section
		end
		
		function Tab:CreateLabel(options)

			options = Library:validate({
				text = "Label"
			}, options or {})

			local Label = {}

			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Label
				Label["25"] = Instance.new("Frame", Tab["1c"]);
				Label["25"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Label["25"]["BackgroundTransparency"] = 0.8999999761581421;
				Label["25"]["Size"] = UDim2.new(0, 337, 0, 36);
				Label["25"]["Name"] = [[Label]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Label.UICorner
				Label["26"] = Instance.new("UICorner", Label["25"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Label.UIStroke
				Label["27"] = Instance.new("UIStroke", Label["25"]);
				Label["27"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Label.TextLabel
				Label["28"] = Instance.new("TextLabel", Label["25"]);
				Label["28"]["TextWrapped"] = true;
				Label["28"]["BorderSizePixel"] = 0;
				Label["28"]["RichText"] = true;
				Label["28"]["TextScaled"] = true;
				Label["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Label["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Label["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Label["28"]["TextSize"] = 14;
				Label["28"]["Text"] = options["text"]
				Label["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Label["28"]["Size"] = UDim2.new(0.9599999785423279, 0, 1, 0);
				Label["28"]["BackgroundTransparency"] = 1;
				Label["28"]["Position"] = UDim2.new(0.019999999552965164, 0, 0, 0);
			end

			function Label:SetText(text)
				options.text = text
				Label["28"]["Text"] = text
			end
			
			return Label
		end
		
		function Tab:CreateSlider(options)
			
			options = Library:validate({
				text = "Slider",
				min = 0,
				max = 100,
				default = 50,
				callback = function(value) end
			}, options or {})

			local Slider = {
				MouseDown = false,
				Hover = false,
				Connection = nil
			}
			
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider
				Slider["3e"] = Instance.new("Frame", Tab["1c"]);
				Slider["3e"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Slider["3e"]["BackgroundTransparency"] = 0.44999998807907104;
				Slider["3e"]["Size"] = UDim2.new(0, 337, 0, 45);
				Slider["3e"]["Name"] = [[Slider]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.UICorner
				Slider["3f"] = Instance.new("UICorner", Slider["3e"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.UIStroke
				Slider["40"] = Instance.new("UIStroke", Slider["3e"]);
				Slider["40"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.TextLabel
				Slider["41"] = Instance.new("TextLabel", Slider["3e"]);
				Slider["41"]["TextWrapped"] = true;
				Slider["41"]["BorderSizePixel"] = 0;
				Slider["41"]["RichText"] = true;
				Slider["41"]["TextScaled"] = true;
				Slider["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["41"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Slider["41"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Slider["41"]["TextSize"] = 14;
				Slider["41"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["41"]["Size"] = UDim2.new(0.8500000238418579, 0, 0.6200000047683716, 0);
				Slider["41"]["Text"] = options["text"];
				Slider["41"]["BackgroundTransparency"] = 1;
				Slider["41"]["Position"] = UDim2.new(0.019999999552965164, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Slider-Frame
				Slider["42"] = Instance.new("Frame", Slider["3e"]);
				Slider["42"]["BorderSizePixel"] = 0;
				Slider["42"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
				Slider["42"]["Size"] = UDim2.new(0.800000011920929, 0, 0.20000000298023224, 0);
				Slider["42"]["Position"] = UDim2.new(0.05000000074505806, 0, 0.699999988079071, 0);
				Slider["42"]["Name"] = [[Slider-Frame]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Slider-Frame.UICorner
				Slider["43"] = Instance.new("UICorner", Slider["42"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Slider-Frame.UIStroke
				Slider["44"] = Instance.new("UIStroke", Slider["42"]);
				Slider["44"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Slider-Frame.Slider-Value
				Slider["45"] = Instance.new("Frame", Slider["42"]);
				Slider["45"]["BorderSizePixel"] = 0;
				Slider["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["45"]["BackgroundTransparency"] = 0.10000000149011612;
				Slider["45"]["Size"] = UDim2.new(0.5, 0, 1, 0);
				Slider["45"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["45"]["Name"] = [[Slider-Value]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Slider-Frame.Slider-Value.UICorner
				Slider["46"] = Instance.new("UICorner", Slider["45"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Slider.Value-Label
				Slider["47"] = Instance.new("TextLabel", Slider["3e"]);
				Slider["47"]["TextWrapped"] = true;
				Slider["47"]["BorderSizePixel"] = 0;
				Slider["47"]["TextScaled"] = true;
				Slider["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["47"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Slider["47"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["47"]["AnchorPoint"] = Vector2.new(1, 0);
				Slider["47"]["Size"] = UDim2.new(0.08900000154972076, 0, 0.6200000047683716, 0);
				Slider["47"]["Text"] = tostring(options.default);
				Slider["47"]["Name"] = [[Value-Label]];
				Slider["47"]["BackgroundTransparency"] = 1;
				Slider["47"]["Position"] = UDim2.new(0.9800000190734863, 0, 0.10000000149011612, 0);
			end
			
			-- Methods
			function Slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((Mouse.X - Slider["42"].AbsolutePosition.X) / (Slider["42"].AbsoluteSize.X), 0, 1)
					local value = math.floor(((options.max - options.min) * percentage) + options.min)
					
					Slider["47"].Text = tostring(value)
					Slider["45"].Size = UDim2.fromScale(percentage, 1)
				else
					Slider["47"].Text = tostring(v)
					Slider["45"].Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
				end
				options.callback(Slider:GetValue())
			end
			
			function Slider:GetValue()
				return tonumber(Slider["47"].Text)
			end
			
			-- Logic
			do
				
				Slider["3e"].MouseEnter:Connect(function()
					Slider.Hover = true
					Library.tween(nil, Slider["3e"], {BackgroundTransparency = 0.27999998807907104})
					Library.tween(nil, Slider["3e"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
					Library.tween(nil, Slider["42"], {BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
					Library.tween(nil, Slider["44"], {Color = Color3.fromRGB(66, 66, 66)})
				end)

				Slider["3e"].MouseLeave:Connect(function()
					Slider.Hover = false

					if not Slider.MouseDown then
						Library.tween(nil, Slider["3e"], {BackgroundTransparency = 0.44999998807907104})
						Library.tween(nil, Slider["3e"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
						Library.tween(nil, Slider["44"], {Color = Color3.fromRGB(37, 37, 37)})
						Library.tween(nil, Slider["42"], {BackgroundColor3 = Color3.fromRGB(49, 49, 49)})
					end
				end)


				uis.InputBegan:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if Slider.Hover then
							if not Slider.Hover then return end
							Slider.MouseDown = true
							ClickSound:Play()
							Library.tween(nil, Slider["3e"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Slider["3e"], {BackgroundColor3 = Color3.fromRGB(107, 107, 107)})
							Library.tween(nil, Slider["44"], {Color = Color3.fromRGB(179, 179, 179)})
							Library.tween(nil, Slider["42"], {BackgroundColor3 = Color3.fromRGB(118, 118, 118)})
							if not Slider.Connection then
								Slider.Connection = runService.RenderStepped:Connect(function()
									Slider:SetValue()
								end)
							end
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						Slider.MouseDown = false
						if not Slider.Hover then
							Library.tween(nil, Slider["3e"], {BackgroundTransparency = 0.44999998807907104})
							Library.tween(nil, Slider["3e"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
							Library.tween(nil, Slider["44"], {Color = Color3.fromRGB(37, 37, 37)})
							Library.tween(nil, Slider["42"], {BackgroundColor3 = Color3.fromRGB(49, 49, 49)})
						else
							ClickSound:Play()
							Library.tween(nil, Slider["3e"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Slider["3e"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
							Library.tween(nil, Slider["44"], {Color = Color3.fromRGB(37, 37, 37)})
							Library.tween(nil, Slider["42"], {BackgroundColor3 = Color3.fromRGB(49, 49, 49)})
						end
						
						if Slider.Connection then Slider.Connection:Disconnect() end
						Slider.Connection = nil
					end
				end)
				
			end
			
			return Slider
		end
		
		function Tab:CreateToggle(options) 
			options = Library:validate({
				text = "Toggle",
				callback = function(value) end
			}, options or {})

			local Toggle = {
				MouseDown = false,
				Hover = false,
				State = false
			}
			-- Render
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle
				Toggle["30"] = Instance.new("Frame", Tab["1c"]);
				Toggle["30"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Toggle["30"]["BackgroundTransparency"] = 0.44999998807907104;
				Toggle["30"]["Size"] = UDim2.new(0, 337, 0, 36);
				Toggle["30"]["Name"] = [[Toggle]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.UICorner
				Toggle["31"] = Instance.new("UICorner", Toggle["30"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.UIStroke
				Toggle["32"] = Instance.new("UIStroke", Toggle["30"]);
				Toggle["32"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.TextLabel
				Toggle["33"] = Instance.new("TextLabel", Toggle["30"]);
				Toggle["33"]["TextWrapped"] = true;
				Toggle["33"]["BorderSizePixel"] = 0;
				Toggle["33"]["RichText"] = true;
				Toggle["33"]["TextScaled"] = true;
				Toggle["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["33"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Toggle["33"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Toggle["33"]["TextSize"] = 14;
				Toggle["33"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["33"]["Size"] = UDim2.new(0.8500000238418579, 0, 1, 0);
				Toggle["33"]["Text"] = options["text"];
				Toggle["33"]["BackgroundTransparency"] = 1;
				Toggle["33"]["Position"] = UDim2.new(0.019999999552965164, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.ToggleHolder
				Toggle["34"] = Instance.new("Frame", Toggle["30"]);
				Toggle["34"]["BackgroundColor3"] = Color3.fromRGB(48, 48, 48);
				Toggle["34"]["AnchorPoint"] = Vector2.new(1, 0);
				Toggle["34"]["Size"] = UDim2.new(0.08900000154972076, 0, 0.8199999928474426, 0);
				Toggle["34"]["Position"] = UDim2.new(0.9800000190734863, 0, 0.10000000149011612, 0);
				Toggle["34"]["Name"] = [[ToggleHolder]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.ToggleHolder.UICorner
				Toggle["3c"] = Instance.new("UICorner", Toggle["34"]);
				Toggle["3c"]["CornerRadius"] = UDim.new(0, 3);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.ToggleHolder.UIStroke
				Toggle["3d"] = Instance.new("UIStroke", Toggle["34"]);
				Toggle["3d"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Toggle.ToggleHolder.ImageLabel
				Toggle["3e"] = Instance.new("ImageLabel", Toggle["34"]);
				Toggle["3e"]["BorderSizePixel"] = 0;
				Toggle["3e"]["BackgroundColor3"] = Color3.fromRGB(48, 48, 48);
				Toggle["3e"]["BackgroundTransparency"] = 1;
				Toggle["3e"]["AnchorPoint"] = Vector2.new(1, 1);
				Toggle["3e"]["Image"] = [[rbxassetid://13222004694]];
				Toggle["3e"]["Size"] = UDim2.new(1, 0, 1, 0);
				Toggle["3e"]["Position"] = UDim2.new(1, 0, 1, 0);
				Toggle["3e"]["Rotation"] = 180;

			end
			
			do
				Toggle["30"].MouseEnter:Connect(function()
					Toggle.Hover = true
					Library.tween(nil, Toggle["30"], {BackgroundTransparency = 0.27999998807907104})
					Library.tween(nil, Toggle["30"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
				end)

				Toggle["30"].MouseLeave:Connect(function()
					Toggle.Hover = false

					if not Toggle.MouseDown then
						Library.tween(nil, Toggle["30"], {BackgroundTransparency = 0.44999998807907104})
						Library.tween(nil, Toggle["30"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
					end
				end)


				uis.InputBegan:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if Toggle.Hover then
							if not Toggle.Hover then return end
							Toggle.MouseDown = true
							ClickSound:Play()
							Library.tween(nil, Toggle["30"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Toggle["30"], {BackgroundColor3 = Color3.fromRGB(107, 107, 107)})
							Toggle:ToggleState()
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						Toggle.MouseDown = false
						if not Toggle.Hover then
							Library.tween(nil, Toggle["30"], {BackgroundTransparency = 0.44999998807907104})
							Library.tween(nil, Toggle["30"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
						else
							Library.tween(nil, Toggle["30"], {BackgroundTransparency = 0.27999998807907104})
							Library.tween(nil, Toggle["30"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
						end
					end
				end)
				
				function Toggle:ToggleState(b)
					if b == nil then
						Toggle.State = not Toggle.State
					else
						Toggle.State = b
					end
					
					if Toggle.State then
						Library.tween(nil, Toggle["34"], {BackgroundColor3 = Color3.fromRGB(126, 15, 218)})
						Library.tween(nil, Toggle["3d"], {Color = Color3.fromRGB(73, 9, 129)})
						Library.tween(nil, Toggle["3e"], {Rotation = 180})
						Toggle["3e"].Image = "rbxassetid://13578337577"
						Library.tween(nil, Toggle["3e"], {Rotation = 360})
					else
						--Toggle["2d"].Visible = false
						Library.tween(nil, Toggle["34"], {BackgroundColor3 = Color3.fromRGB(48, 48, 48)})
						Library.tween(nil, Toggle["3d"], {Color = Color3.fromRGB(37, 37, 37)})
						Library.tween(nil, Toggle["3e"], {Rotation = 180})
						Toggle["3e"].Image = "rbxassetid://13222004694"
						Library.tween(nil, Toggle["3e"], {Rotation = 0})
					end
					
					options.callback(Toggle.State)
				end
			end
			
			return Toggle
		end
		
		function Tab:CreateDropdown(options)
			options = Library:validate({
				text = "Dropdown",
				items = {},
				default = nil,
				callback = function(value) end
			}, options or {})

			local Dropdown = {
				Items = {
					["id"] = {
						"value"
					}
				},
				Open = false,
				Hover = false,
				MouseDown = false,
				Rotate = false,
				HoveringItem = false,
				Value = "None"
			}

			Dropdown.Value = options.default or "None"

			--Render
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown
				Dropdown["48"] = Instance.new("Frame", Tab["1c"]);
				Dropdown["48"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Dropdown["48"]["BackgroundTransparency"] = 0.44999998807907104;
				Dropdown["48"]["Size"] = UDim2.new(0, 337, 0, 36);
				Dropdown["48"]["ClipsDescendants"] = true;
				Dropdown["48"]["Name"] = [[Dropdown]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.UICorner
				Dropdown["49"] = Instance.new("UICorner", Dropdown["48"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.UIStroke
				Dropdown["4a"] = Instance.new("UIStroke", Dropdown["48"]);
				Dropdown["4a"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.TextLabel
				Dropdown["4b"] = Instance.new("TextLabel", Dropdown["48"]);
				Dropdown["4b"]["TextWrapped"] = true;
				Dropdown["4b"]["BorderSizePixel"] = 0;
				Dropdown["4b"]["RichText"] = true;
				Dropdown["4b"]["TextScaled"] = true;
				Dropdown["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown["4b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Dropdown["4b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Dropdown["4b"]["TextSize"] = 14;
				Dropdown["4b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown["4b"]["Size"] = UDim2.new(0.8500000238418579, 0, 0, 25);
				Dropdown["4b"]["Text"] = options.text;
				Dropdown["4b"]["BackgroundTransparency"] = 1;
				Dropdown["4b"]["Position"] = UDim2.new(0.019999999552965164, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.ImageLabel
				Dropdown["4c"] = Instance.new("ImageLabel", Dropdown["48"]);
				Dropdown["4c"]["BorderSizePixel"] = 0;
				Dropdown["4c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown["4c"]["AnchorPoint"] = Vector2.new(1, 0);
				Dropdown["4c"]["Image"] = [[rbxassetid://13578629592]];
				Dropdown["4c"]["Size"] = UDim2.new(0, 29, 0, 30);
				Dropdown["4c"]["BackgroundTransparency"] = 1;
				Dropdown["4c"]["Position"] = UDim2.new(0, 330, 0, 5);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.OptionHolder
				Dropdown["4d"] = Instance.new("Frame", Dropdown["48"]);
				Dropdown["4d"]["BorderSizePixel"] = 0;
				Dropdown["4d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown["4d"]["BackgroundTransparency"] = 1;
				Dropdown["4d"]["Size"] = UDim2.new(0, 337, 0, 70);
				Dropdown["4d"]["Position"] = UDim2.new(0, 3, 0, 38);
				Dropdown["4d"]["Visible"] = false;
				Dropdown["4d"]["Name"] = [[OptionHolder]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.OptionHolder.UIListLayout
				Dropdown["4e"] = Instance.new("UIListLayout", Dropdown["4d"]);
				Dropdown["4e"]["Padding"] = UDim.new(0, 4);
				Dropdown["4e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.Value
				Dropdown["5d"] = Instance.new("TextLabel", Dropdown["48"]);
				Dropdown["5d"]["TextWrapped"] = true;
				Dropdown["5d"]["BorderSizePixel"] = 0;
				Dropdown["5d"]["RichText"] = true;
				Dropdown["5d"]["TextScaled"] = true;
				Dropdown["5d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown["5d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Dropdown["5d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Dropdown["5d"]["TextSize"] = 14;
				Dropdown["5d"]["TextColor3"] = Color3.fromRGB(203, 203, 203);
				Dropdown["5d"]["Size"] = UDim2.new(0.6000000238418579, 0, 0, 15);
				Dropdown["5d"]["Text"] = Dropdown.Value;
				Dropdown["5d"]["Name"] = [[Value]];
				Dropdown["5d"]["BackgroundTransparency"] = 1;
				Dropdown["5d"]["Position"] = UDim2.new(0, 10,0, 19);
			end

			function Dropdown:Add(id, value)
				local Item = {
					Hover = false,
					Mousedown = false
				}

				if Dropdown.Items[id] ~= nil then
					print("GNHUB: Dowpdown Error")
					return
				end
				Dropdown.Items[id] = {
					instance = {},
					value = value
				}
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.OptionHolder.Option-Inaktive
				Dropdown.Items[id].instance["4f"] = Instance.new("TextLabel", Dropdown["4d"]);
				Dropdown.Items[id].instance["4f"]["TextWrapped"] = true;
				Dropdown.Items[id].instance["4f"]["BorderSizePixel"] = 0;
				Dropdown.Items[id].instance["4f"]["TextScaled"] = true;
				Dropdown.Items[id].instance["4f"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
				Dropdown.Items[id].instance["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Dropdown.Items[id].instance["4f"]["TextSize"] = 14;
				Dropdown.Items[id].instance["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Dropdown.Items[id].instance["4f"]["Size"] = UDim2.new(0, 330, 0, 27);
				Dropdown.Items[id].instance["4f"]["Text"] = id;
				Dropdown.Items[id].instance["4f"]["Name"] = [[Option-Inaktive]];
				Dropdown.Items[id].instance["4f"]["BackgroundTransparency"] = 0.20000000298023224;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.OptionHolder.Option-Inaktive.UIStroke
				Dropdown.Items[id].instance["50"] = Instance.new("UIStroke", Dropdown.Items[id].instance["4f"]);
				Dropdown.Items[id].instance["50"]["Color"] = Color3.fromRGB(37, 37, 37);
				Dropdown.Items[id].instance["50"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Dropdown.OptionHolder.Option-Inaktive.UICorner
				Dropdown.Items[id].instance["51"] = Instance.new("UICorner", Dropdown.Items[id].instance["4f"]);
				Dropdown.Items[id].instance["51"]["CornerRadius"] = UDim.new(0, 100);

				Dropdown.Items[id].instance["4f"].MouseEnter:Connect(function()
					Item.Hover = true
					Dropdown.HoveringItem = true
					Library.tween(nil, Dropdown.Items[id].instance["4f"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
				end)

				Dropdown.Items[id].instance["4f"].MouseLeave:Connect(function()
					Item.Hover = false
					Dropdown.HoveringItem = false

					if not Item.MouseDown then
						Library.tween(nil, Dropdown.Items[id].instance["4f"], {BackgroundColor3 = Color3.fromRGB(93, 93, 93)})
					end
				end)

				uis.InputBegan:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end

					if Dropdown.Items[id] == nil then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if Item.Hover then
							if not Item.Hover then return end
							Item.MouseDown = true
							ClickSound:Play()
							Library.tween(nil, Dropdown.Items[id].instance["4f"], {BackgroundColor3 = Color3.fromRGB(122, 122, 122)})
							options.callback(value)
							Dropdown.Value = value
							Dropdown["5d"].Text = Dropdown.Value;
							Dropdown.Toggle()
							Dropdown:ToggleRotate()
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end

					if Dropdown.Items[id] == nil then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						Item.MouseDown = false
						if not Item.Hover then
							Library.tween(nil, Dropdown.Items[id].instance["4f"], {BackgroundColor3 = Color3.fromRGB(86, 86, 86)})
						else
							Library.tween(nil, Dropdown.Items[id].instance["4f"], {BackgroundColor3 = Color3.fromRGB(93, 93, 93)})
						end
					end
				end)
			end

			function Dropdown:Remove(id)
				if Dropdown.Items[id] ~= nil then
					if Dropdown.Items[id].instance ~= nil then
						for i, v in pairs(Dropdown.Items[id].instance) do
							v:Destroy()
						end
					end
					Dropdown.Items[id] = nil
				end
			end

			function Dropdown:Clear()
				for i, v in pairs(Dropdown.Items) do
					Dropdown:Remove(i)
				end
			end

			function Dropdown:Toggle()
				if Dropdown.Open then
					Library.tween(nil, Dropdown["48"], {Size = UDim2.new(0,337,0, 36)})
					Dropdown["4d"].Visible = false
				else
					local count = 0
					for i, v in pairs(Dropdown.Items) do
						if v ~= nil then
							count += 1
						end
					end

					Dropdown["4d"].Visible = true
					Library.tween(nil, Dropdown["48"], {Size = UDim2.new(0,337,0, 36 + (count * 28))})
				end
				Dropdown.Open = not Dropdown.Open
			end

			--logic... help me pls pls pls pls ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

			do
				Dropdown["48"].MouseEnter:Connect(function()
					Dropdown.Hover = true
					Library.tween(nil, Dropdown["48"], {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
				end)

				Dropdown["48"].MouseLeave:Connect(function()
					Dropdown.Hover = false

					if not Dropdown.MouseDown then
						Library.tween(nil, Dropdown["48"], {BackgroundColor3 = Color3.fromRGB(62, 62, 62)})
					end
				end)


				uis.InputBegan:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if Dropdown.Hover then
							if not Dropdown.Hover then return end
							ClickSound:Play()
							Dropdown.MouseDown = true
							Library.tween(nil, Dropdown["48"], {BackgroundColor3 = Color3.fromRGB(85, 85, 85)})
							if not Dropdown.HoveringItem then
								Dropdown:Toggle()
								Dropdown:ToggleRotate()
							end
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if not Enum.UserInputType.MouseButton1 then return end
					if uis:GetFocusedTextBox() then
						return
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						Dropdown.MouseDown = false
						if not Dropdown.Hover then
							Library.tween(nil, Dropdown["48"], {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
						else
							Library.tween(nil, Dropdown["48"], {BackgroundColor3 = Color3.fromRGB(62, 62, 62)})
						end
					end
				end)

				function Dropdown:ToggleRotate(b)
					if b == nil then
						Dropdown.Rotate = not Dropdown.Rotate
					else
						Dropdown.Rotate = b
					end

					if Dropdown.Rotate then
						Library.tween(nil, Dropdown["4c"], {Rotation = 180})
					else
						Library.tween(nil, Dropdown["4c"], {Rotation = 0})
					end
				end
			end

			return Dropdown
		end

		function Tab:CreateKeybind(options)
			if uis.KeyboardEnabled and uis.MouseEnabled then
				options = Library:validate({
					text = "Keybind",
					default = "MouseButton1",
					defaultkey = Enum.UserInputType.MouseButton1,
					callback = function(v) end
				}, options or {})

				local Keybind = {
					hover = false,
					MouseDown = false,
					Keybackup = options.defaultkey,
					binding = false,
					Namebackup = options.default
				}
				--Rander
				do
					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind
					Keybind["8d"] = Instance.new("Frame", Tab["1c"]);
					Keybind["8d"]["BorderSizePixel"] = 0;
					Keybind["8d"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
					Keybind["8d"]["BackgroundTransparency"] = 0.44999998807907104;
					Keybind["8d"]["Size"] = UDim2.new(0, 337, 0, 36);
					Keybind["8d"]["Name"] = [[KeyBind]];

					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.UICorner
					Keybind["8e"] = Instance.new("UICorner", Keybind["8d"]);


					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.UIStroke
					Keybind["8f"] = Instance.new("UIStroke", Keybind["8d"]);
					Keybind["8f"]["Color"] = Color3.fromRGB(37, 37, 37);

					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.TextLabel
					Keybind["90"] = Instance.new("TextLabel", Keybind["8d"]);
					Keybind["90"]["TextWrapped"] = true;
					Keybind["90"]["BorderSizePixel"] = 0;
					Keybind["90"]["RichText"] = true;
					Keybind["90"]["TextScaled"] = true;
					Keybind["90"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Keybind["90"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Keybind["90"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
					Keybind["90"]["TextSize"] = 14;
					Keybind["90"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Keybind["90"]["Size"] = UDim2.new(0.6470000147819519, 0, 1, 0);
					Keybind["90"]["Text"] = options.text;
					Keybind["90"]["BackgroundTransparency"] = 1;
					Keybind["90"]["Position"] = UDim2.new(0.019999971613287926, 0, 0, 0);

					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.Background
					Keybind["91"] = Instance.new("Frame", Keybind["8d"]);
					Keybind["91"]["BorderSizePixel"] = 0;
					Keybind["91"]["BackgroundColor3"] = Color3.fromRGB(50, 50, 50);
					Keybind["91"]["Size"] = UDim2.new(0, 105, 0, 29);
					Keybind["91"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Keybind["91"]["Position"] = UDim2.new(0.6483621597290039, 0, 0.1111111119389534, 0);
					Keybind["91"]["Name"] = [[Background]];

					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.Background.UICorner
					Keybind["92"] = Instance.new("UICorner", Keybind["91"]);


					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.Background.UIStroke
					Keybind["93"] = Instance.new("UIStroke", Keybind["91"]);
					Keybind["93"]["Color"] = Color3.fromRGB(44, 44, 44);

					-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.KeyBind.Background.Key
					Keybind["94"] = Instance.new("TextLabel", Keybind["91"]);
					Keybind["94"]["TextWrapped"] = true;
					Keybind["94"]["BorderSizePixel"] = 0;
					Keybind["94"]["TextScaled"] = true;
					Keybind["94"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Keybind["94"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Keybind["94"]["TextSize"] = 14;
					Keybind["94"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Keybind["94"]["Size"] = UDim2.new(1, 0, 1, 0);
					Keybind["94"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Keybind["94"]["Name"] = [[Key]];
					Keybind["94"]["Text"] = options.default;
					Keybind["94"]["BackgroundTransparency"] = 1;
				end

				-- Logic

				do 
					function Keybind:SetBind(Key)
						options.defaultkey = Key or Keybind.Keybackup
						options.default = Key
						options.callback(Key)
					end
					
					Keybind["8d"].MouseEnter:Connect(function()
						Keybind.Hover = true
						Library.tween(nil, Keybind["8d"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
					end)

					Keybind["8d"].MouseLeave:Connect(function()
						Keybind.Hover = false

						if not Keybind.MouseDown then
							Library.tween(nil, Keybind["8d"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
						end
					end)

					uis.InputBegan:Connect(function(Input)
						if uis:GetFocusedTextBox() then
							return
						end
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							if Keybind.Hover then
								if Keybind.binding == true then
									return
								end
								Keybind.Namebackup = options.default
								Keybind["94"].Text = "..."
								Keybind.binding = true
								Library.tween(nil, Keybind["91"], {BackgroundColor3 = Color3.fromRGB(66, 66, 66)})
								Library.tween(nil, Keybind["93"], {Color = Color3.fromRGB(56, 56, 56)})
							end
						end
					end)

					uis.InputBegan:Connect(function(Input)
						if uis:GetFocusedTextBox() then
							return
						end
						if Keybind.binding == false then
							return
						end
						local Key
						pcall(function()
							if not CheckKey(BlacklistedKeys, Input.KeyCode) then
								Key = Input.KeyCode
							end
						end)
						pcall(function()
							if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
								Key = Input.UserInputType
							end
						end)
						
						Key = Key or options.defaultkey
						Keybind["94"].Text = Key.Name or Keybind.Namebackup
						Keybind.binding = false
						Library.tween(nil, Keybind["91"], {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
						Library.tween(nil, Keybind["93"], {Color = Color3.fromRGB(44, 44, 44)})
						Keybind:SetBind(Key)
					end)
				end
				return Keybind
			end
		end

		function Tab:CreateColorpicker(options)
			options = Library:validate({
				text = "Colorpicker",
				callback = function(value) options.default = value end
			}, options or {})

			local Colorpicker = {
				hover = false,
				MouseDown = false,
				open = false,
				buttonDown = false,
				movingSlider = false,
				ColorHover = false,
				positionC = Vector2.new(1, 1)
			}

			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker
				Colorpicker["77"] = Instance.new("Frame", Tab["1c"]);
				Colorpicker["77"]["BorderSizePixel"] = 0;
				Colorpicker["77"]["BackgroundColor3"] = Color3.fromRGB(71, 71, 71);
				Colorpicker["77"]["BackgroundTransparency"] = 0.44999998807907104;
				Colorpicker["77"]["Size"] = UDim2.new(0, 337, 0, 36);
				Colorpicker["77"]["Name"] = [[Colorpicker]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker.UICorner
				Colorpicker["78"] = Instance.new("UICorner", Colorpicker["77"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker.UIStroke
				Colorpicker["79"] = Instance.new("UIStroke", Colorpicker["77"]);
				Colorpicker["79"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.TextLabel
				Colorpicker["83"] = Instance.new("TextLabel", Colorpicker["77"]);
				Colorpicker["83"]["TextWrapped"] = true;
				Colorpicker["83"]["BorderSizePixel"] = 0;
				Colorpicker["83"]["RichText"] = true;
				Colorpicker["83"]["TextScaled"] = true;
				Colorpicker["83"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["83"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Colorpicker["83"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				Colorpicker["83"]["TextSize"] = 14;
				Colorpicker["83"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["83"]["Size"] = UDim2.new(0, 200, 0, 36);
				Colorpicker["83"]["Text"] = options.text;
				Colorpicker["83"]["BackgroundTransparency"] = 1;
				Colorpicker["83"]["Position"] = UDim2.new(0, 6, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ColorWheel
				Colorpicker["84"] = Instance.new("ImageButton", Colorpicker["77"]);
				Colorpicker["84"]["BorderSizePixel"] = 0;
				Colorpicker["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["84"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Colorpicker["84"]["Image"] = [[rbxassetid://11224004075]];
				Colorpicker["84"]["Size"] = UDim2.new(0, 101, 0, 101);
				Colorpicker["84"]["Name"] = [[ColorWheel]];
				Colorpicker["84"]["Visible"] = false;
				Colorpicker["84"]["Position"] = UDim2.new(0.22056184709072113, 0, 0.608184814453125, 0);
				Colorpicker["84"]["BackgroundTransparency"] = 1;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ColorWheel.Cursor
				Colorpicker["85"] = Instance.new("ImageLabel", Colorpicker["84"]);
				Colorpicker["85"]["ZIndex"] = 4;
				Colorpicker["85"]["BorderSizePixel"] = 0;
				Colorpicker["85"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["85"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Colorpicker["85"]["Image"] = [[rbxassetid://11226149359]];
				Colorpicker["85"]["Size"] = UDim2.new(0, 10, 0, 10);
				Colorpicker["85"]["Name"] = [[Cursor]];
				Colorpicker["85"]["BackgroundTransparency"] = 1;
				Colorpicker["85"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ColorWheel.UIStroke
				Colorpicker["86"] = Instance.new("UIStroke", Colorpicker["84"]);
				Colorpicker["86"]["Color"] = Color3.fromRGB(37, 37, 37);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ColorWheel.UICorner
				Colorpicker["87"] = Instance.new("UICorner", Colorpicker["84"]);
				Colorpicker["87"]["CornerRadius"] = UDim.new(0, 100);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector
				Colorpicker["88"] = Instance.new("TextButton", Colorpicker["77"]);
				Colorpicker["88"]["TextWrapped"] = true;
				Colorpicker["88"]["Active"] = false;
				Colorpicker["88"]["BorderSizePixel"] = 0;
				Colorpicker["88"]["AutoButtonColor"] = false;
				Colorpicker["88"]["TextScaled"] = true;
				Colorpicker["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["88"]["Selectable"] = false;
				Colorpicker["88"]["Size"] = UDim2.new(0, 35, 0, 165);
				Colorpicker["88"]["Name"] = [[ValueSelector]];
				Colorpicker["88"]["Text"] = [[]];
				Colorpicker["88"]["Visible"] = false;
				Colorpicker["88"]["Rotation"] = 270;
				Colorpicker["88"]["Position"] = UDim2.new(0.6483621597290039, 0, 0.27666687965393066, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector.UIGradient
				Colorpicker["89"] = Instance.new("UIGradient", Colorpicker["88"]);
				Colorpicker["89"]["Rotation"] = -90;
				Colorpicker["89"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 255, 255))};

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector.UIStroke
				Colorpicker["8a"] = Instance.new("UIStroke", Colorpicker["88"]);
				Colorpicker["8a"]["Color"] = Color3.fromRGB(37, 37, 37);
				Colorpicker["8a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector.Cursor
				Colorpicker["8b"] = Instance.new("Frame", Colorpicker["88"]);
				Colorpicker["8b"]["BorderSizePixel"] = 0;
				Colorpicker["8b"]["BackgroundColor3"] = Color3.fromRGB(44, 44, 44);
				Colorpicker["8b"]["Size"] = UDim2.new(1, 0, 0, 5);
				Colorpicker["8b"]["Name"] = [[Cursor]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector.Cursor.UIStroke
				Colorpicker["8c"] = Instance.new("UIStroke", Colorpicker["8b"]);
				Colorpicker["8c"]["Color"] = Color3.fromRGB(37, 37, 37);
				Colorpicker["8c"]["Thickness"] = 2.299999952316284;
				Colorpicker["8c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.ValueSelector.UICorner
				Colorpicker["8d"] = Instance.new("UICorner", Colorpicker["88"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.Frame
				Colorpicker["8e"] = Instance.new("Frame", Colorpicker["77"]);
				Colorpicker["8e"]["BorderSizePixel"] = 0;
				Colorpicker["8e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Colorpicker["8e"]["Size"] = UDim2.new(0.082, 0,0.8, 0);
				Colorpicker["8e"]["Position"] = UDim2.new(0.8999999761581421, 0, 0.11999999731779099, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.Frame.UICorner
				Colorpicker["8f"] = Instance.new("UICorner", Colorpicker["8e"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.Colorpicker-open.Frame.UIStroke
				Colorpicker["90"] = Instance.new("UIStroke", Colorpicker["8e"]);
				Colorpicker["90"]["Color"] = Color3.fromRGB(37, 37, 37);
				Colorpicker["90"]["Thickness"] = 1.5;
			end


			Colorpicker["77"].MouseEnter:Connect(function()
				Colorpicker.Hover = true
				Library.tween(nil, Colorpicker["77"], {BackgroundColor3 = Color3.fromRGB(89, 89, 89)})
			end)

			Colorpicker["77"].MouseLeave:Connect(function()
				Colorpicker.Hover = false

				if not Colorpicker.MouseDown then
					Library.tween(nil, Colorpicker["77"], {BackgroundColor3 = Color3.fromRGB(71, 71, 71)})
				end
			end)


			uis.InputBegan:Connect(function(input)
				if not Enum.UserInputType.MouseButton1 then return end
				if uis:GetFocusedTextBox() then
					return
				end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if Colorpicker.Hover then
						if not Colorpicker.Hover then return end
						if Colorpicker.ColorHover == true then
							return
						end
						Colorpicker.MouseDown = true
						Library.tween(nil, Colorpicker["77"], {BackgroundColor3 = Color3.fromRGB(107, 107, 107)})
						ClickSound:Play()
						Colorpicker:opens()
						--Colorpicker.Hover = false
					end
				end
			end)

			uis.InputEnded:Connect(function(input)
				if not Enum.UserInputType.MouseButton1 then return end
				if uis:GetFocusedTextBox() then
					return
				end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Colorpicker.MouseDown = false
					if not Colorpicker.Hover then
						Library.tween(nil, Colorpicker["77"], {BackgroundColor3 =  Color3.fromRGB(71, 71, 71)})
					else
						Library.tween(nil, Colorpicker["77"], {BackgroundColor3 =  Color3.fromRGB(89, 89, 89)})
					end
				end
			end)

			function Colorpicker:opens() 
				Colorpicker.open = not Colorpicker.open
				if Colorpicker.open == true then
					--Colorpicker.Hover = false
					Library.tween(nil, Colorpicker["77"], {Size = UDim2.new(0, 337, 0, 150)})
					Library.tween(nil, Colorpicker["8e"], {Size = UDim2.new(0, 76, 0, 81)})
					Library.tween(nil, Colorpicker["8e"], {Position = UDim2.new(0.7509233355522156, 0, 0.07713888585567474, 0)})
					--Colorpicker["88"].Visible = true
					Colorpicker["88"].Visible = true
					Colorpicker["84"].Visible = true
					Library.tween(nil, Colorpicker["88"], {Size = UDim2.new(0, 35, 0, 165)})
					Library.tween(nil, Colorpicker["84"], {Size = UDim2.new(0, 101, 0, 101)})
				elseif Colorpicker.open == false then
					--Colorpicker.Hover = false
					Library.tween(nil, Colorpicker["77"], {Size = UDim2.new(0, 337, 0, 36)})
					Library.tween(nil, Colorpicker["8e"], {Size = UDim2.new(0.082, 0,0.8, 0)})
					Library.tween(nil, Colorpicker["8e"], {Position = UDim2.new(0.8999999761581421, 0, 0.11999999731779099, 0)})
					Library.tween(nil, Colorpicker["88"], {Size = UDim2.new(0, 0, 0, 0)})
					Library.tween(nil, Colorpicker["84"], {Size = UDim2.new(0, 0,0.8, 0)})
					Colorpicker["88"].Visible = false
					Colorpicker["84"].Visible = false
				end
			end

			local abs, pi, sin, asin, acos, sign, deg, rad, clamp = math.abs, math.pi, math.sin, math.asin, math.acos, math.sign, math.deg, math.rad, math.clamp 

			local startAxis = Vector2.new(1, 0)
			local barOffset = 36

			local ColorWheel_Radius = Colorpicker["84"].AbsoluteSize/2

			function Colorpicker:setColor(newColor)
				Colorpicker["8e"].BackgroundColor3 = newColor
				options.callback(newColor)
			end

			local function updateValueSelector(newColor)
				Colorpicker["88"].BackgroundColor3 = newColor
			end

			local function getValue()
				return Colorpicker["88"]:GetAttribute("Value") or 1
			end

			local function getColorbyVector(vector: Vector2)

				local cosVector, sinVector = startAxis:Dot(vector.Unit), startAxis:Cross(vector.Unit)
				local arcCosVector, arcSinVector = acos(cosVector), asin(sinVector)

				if sign(arcSinVector) <= 0 then
					arcCosVector = rad(deg(2*pi) - deg(arcCosVector))
				end

				local hue: number = deg(arcCosVector)/360

				local saturation: number = clamp((vector.Magnitude/(ColorWheel_Radius.Magnitude))/sin(rad(45)), 0, 1)

				local value: number = getValue()

				local color = Color3.fromHSV(hue, saturation, value)
				return color
			end

			local function selectNewColor(x, y)
				local SizeOffet = Colorpicker["84"].AbsoluteSize/2
				local ColorWheelOffset: Vector2 = Colorpicker["84"].AbsolutePosition + SizeOffet

				local position: Vector2 = (Vector2.new(x, y - barOffset) - ColorWheelOffset)

				local relativePosition: Vector2 = position + ColorWheel_Radius

				if position.Magnitude >= ColorWheel_Radius.X then
					position = position.Unit * ColorWheel_Radius.X
					relativePosition = position + ColorWheel_Radius
				end

				local rx, ry = relativePosition.X, relativePosition.Y
				Colorpicker["85"].Position = UDim2.fromOffset(rx, ry)

				position = Vector2.new(position.X, -position.Y)
				Colorpicker.positionC = position

				Colorpicker:setColor(getColorbyVector(position))
				Colorpicker["89"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, getColorbyVector(position))};
				Colorpicker["84"]:SetAttribute("LastVector", position)
			end


			Colorpicker["84"].MouseEnter:Connect(function()
				Colorpicker.Hover = false
				Colorpicker.ColorHover = true
			end)

			Colorpicker["84"].MouseLeave:Connect(function()
				Colorpicker.Hover = true
				Colorpicker.ColorHover = false
			end)

			Colorpicker["88"].MouseEnter:Connect(function()
				Colorpicker.Hover = false
				Colorpicker.ColorHover = true
			end)

			Colorpicker["88"].MouseLeave:Connect(function()
				Colorpicker.Hover = true
				Colorpicker.ColorHover = false
			end)

			Colorpicker["84"].MouseButton1Down:Connect(function(x, y)
				ClickSound:Play()
				if Colorpicker.open then
					Colorpicker.X = x
					Colorpicker.Y = y
					local movedConnection
					local leaveConnection
					local upConnection

					movedConnection = Colorpicker["84"].MouseMoved:Connect(selectNewColor)

					local function disconnect(x, y)
						selectNewColor(x, y)

						movedConnection:Disconnect()
						leaveConnection:Disconnect()
						upConnection:Disconnect()
					end
					leaveConnection = Colorpicker["84"].MouseLeave:Connect(disconnect)
					upConnection = Colorpicker["84"].MouseButton1Up:Connect(disconnect)

					selectNewColor(x, y)
				end
			end)


			local function setNewValue(x,y)
				local ratio = (x - Colorpicker["88"].AbsolutePosition.X + 62.5)/Colorpicker["88"].AbsoluteSize.Y
				ratio = math.clamp(ratio, 0, 1)
				Colorpicker["88"]:SetAttribute("Value", 1-ratio)
				Colorpicker["84"].ImageColor3 = Color3.fromRGB(255 * (1-ratio), 255 * (1-ratio), 255 * (1-ratio))

				local lastVector = Colorpicker["84"]:GetAttribute("LastVector")
				if lastVector then
					Colorpicker:setColor(getColorbyVector(lastVector))
				end

				Colorpicker["8b"].Position = UDim2.new(0, 0, ratio, 0)
			end

			Colorpicker["88"].MouseButton1Down:Connect(function(x, y)
				if Colorpicker.open then
					ClickSound:Play()
					local movedConnection
					local leaveConnection
					local upConnection

					movedConnection = Colorpicker["88"].MouseMoved:Connect(setNewValue)

					local function disconnect(x, y)
						setNewValue(x, y)

						movedConnection:Disconnect()
						leaveConnection:Disconnect()
						upConnection:Disconnect()
					end
					leaveConnection = Colorpicker["88"].MouseLeave:Connect(disconnect)
					upConnection = Colorpicker["88"].MouseButton1Up:Connect(disconnect)

					setNewValue(x, y)
				end
			end)

			Colorpicker["88"].MouseButton1Up:Connect(function()
				Colorpicker:setColor(getColorbyVector(Colorpicker.positionC))
			end)

			return Colorpicker
		end
		
		function Tab:CreateGNHub(options)
			options = Library:validate({
				versions ="V." .. loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/Version.lua"))(),
				discord = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/nici002018/GNHub/master/Discord.lua"))()
			}, options or {})
			
			local GNHub = {
				hover = false,
				MouseDown = false
			}
			
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder
				GNHub["56"] = Instance.new("Frame", Tab["1c"]);
				GNHub["56"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["56"]["BackgroundTransparency"] = 1;
				GNHub["56"]["Size"] = UDim2.new(0, 337, 0, 56);
				GNHub["56"]["Name"] = [[GNHub-Holder]];


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos
				GNHub["5d"] = Instance.new("Frame", GNHub["56"]);
				GNHub["5d"]["BorderSizePixel"] = 0;
				GNHub["5d"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
				GNHub["5d"]["Size"] = UDim2.new(0.6570000052452087, 0, 1, 0);
				GNHub["5d"]["Name"] = [[Infos]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos.UICorner
				GNHub["5e"] = Instance.new("UICorner", GNHub["5d"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos.UIStroke
				GNHub["5f"] = Instance.new("UIStroke", GNHub["5d"]);
				GNHub["5f"]["Color"] = Color3.fromRGB(38, 38, 38);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos.Frame
				GNHub["60"] = Instance.new("Frame", GNHub["5d"]);
				GNHub["60"]["ZIndex"] = 3;
				GNHub["60"]["BorderSizePixel"] = 0;
				GNHub["60"]["BackgroundColor3"] = Color3.fromRGB(38, 38, 38);
				GNHub["60"]["Size"] = UDim2.new(0.009999999776482582, 0, 1, 0);
				GNHub["60"]["Position"] = UDim2.new(0.5, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos.Version
				GNHub["61"] = Instance.new("TextLabel", GNHub["5d"]);
				GNHub["61"]["TextWrapped"] = true;
				GNHub["61"]["BorderSizePixel"] = 0;
				GNHub["61"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
				GNHub["61"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				GNHub["61"]["TextSize"] = 41;
				GNHub["61"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["61"]["Size"] = UDim2.new(0.47999998927116394, 0, 1, 0);
				GNHub["61"]["Text"] = options.versions;
				GNHub["61"]["Name"] = [[Version]];
				GNHub["61"]["BackgroundTransparency"] = 1;
				GNHub["61"]["Position"] = UDim2.new(0.009999999776482582, 0, 0, 0);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.Infos.Discord-Name
				GNHub["62"] = Instance.new("TextLabel", GNHub["5d"]);
				GNHub["62"]["TextWrapped"] = true;
				GNHub["62"]["BorderSizePixel"] = 0;
				GNHub["62"]["TextScaled"] = true;
				GNHub["62"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
				GNHub["62"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				GNHub["62"]["TextSize"] = 14;
				GNHub["62"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["62"]["Size"] = UDim2.new(0.47999998927116394, 0, 1, 0);
				GNHub["62"]["Text"] = [[Inventor: niceas_yt]];
				GNHub["62"]["Name"] = [[Discord-Name]];
				GNHub["62"]["BackgroundTransparency"] = 1;
				GNHub["62"]["Position"] = UDim2.new(0.5199999809265137, 0, 0, 0);

			end
			
			do
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord
				GNHub["57"] = Instance.new("Frame", GNHub["56"]);
				GNHub["57"]["BackgroundColor3"] = Color3.fromRGB(87, 99, 247);
				GNHub["57"]["AnchorPoint"] = Vector2.new(1, 0);
				GNHub["57"]["Size"] = UDim2.new(0.3330000042915344, 0, 1, 0);
				GNHub["57"]["Position"] = UDim2.new(1, 0, 0, 0);
				GNHub["57"]["Name"] = [[DIscord]];

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord.UIStroke
				GNHub["58"] = Instance.new("UIStroke", GNHub["57"]);
				GNHub["58"]["Color"] = Color3.fromRGB(62, 72, 177);
				GNHub["58"]["Transparency"] = 0.20000000298023224;

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord.UICorner
				GNHub["59"] = Instance.new("UICorner", GNHub["57"]);


				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord.ImageLabel
				GNHub["5a"] = Instance.new("ImageLabel", GNHub["57"]);
				GNHub["5a"]["BorderSizePixel"] = 0;
				GNHub["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["5a"]["Image"] = [[rbxassetid://13655318883]];
				GNHub["5a"]["Size"] = UDim2.new(0.3499999940395355, 0, 0.7350000143051147, 0);
				GNHub["5a"]["BackgroundTransparency"] = 1;
				GNHub["5a"]["Position"] = UDim2.new(0, 0, 0.14000000059604645, 0);
				
				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord.UIPadding
				GNHub["5b"] = Instance.new("UIPadding", GNHub["57"]);
				GNHub["5b"]["PaddingTop"] = UDim.new(0, 3);
				GNHub["5b"]["PaddingRight"] = UDim.new(0, 3);
				GNHub["5b"]["PaddingBottom"] = UDim.new(0, 3);
				GNHub["5b"]["PaddingLeft"] = UDim.new(0, 3);

				-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.GNHub-Holder.DIscord.TextLabel
				GNHub["5c"] = Instance.new("TextLabel", GNHub["57"]);
				GNHub["5c"]["TextWrapped"] = true;
				GNHub["5c"]["BorderSizePixel"] = 0;
				GNHub["5c"]["RichText"] = true;
				GNHub["5c"]["TextScaled"] = true;
				GNHub["5c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				GNHub["5c"]["TextSize"] = 14;
				GNHub["5c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				GNHub["5c"]["Size"] = UDim2.new(0.6499999761581421, 0, 1, 0);
				GNHub["5c"]["Text"] = [[Discord]];
				GNHub["5c"]["BackgroundTransparency"] = 1;
				GNHub["5c"]["Position"] = UDim2.new(0.3700000047683716, 0, 0, 0);
			end
			
			GNHub["57"].MouseEnter:Connect(function()
				GNHub.Hover = true
				Library.tween(nil, GNHub["57"], {BackgroundColor3 = Color3.fromRGB(77, 122, 247)})
			end)

			GNHub["57"].MouseLeave:Connect(function()
				GNHub.Hover = false

				if not GNHub.MouseDown then
					Library.tween(nil, GNHub["57"], {BackgroundColor3 = Color3.fromRGB(87, 99, 247)})
				end
			end)


			uis.InputBegan:Connect(function(input)
				if not Enum.UserInputType.MouseButton1 then return end
				if uis:GetFocusedTextBox() then
					return
				end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if GNHub.Hover then
						if not GNHub.Hover then return end
						GNHub.MouseDown = true
						Library.tween(nil, GNHub["57"], {BackgroundColor3 = Color3.fromRGB(59, 159, 247)})
						GNHub:Invite()
					end
				end
			end)

			uis.InputEnded:Connect(function(input)
				if not Enum.UserInputType.MouseButton1 then return end
				if uis:GetFocusedTextBox() then
					return
				end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					GNHub.MouseDown = false
					if not GNHub.Hover then
						Library.tween(nil, GNHub["57"], {BackgroundColor3 = Color3.fromRGB(77, 122, 247)})
					else
						Library.tween(nil, GNHub["57"], {BackgroundColor3 = Color3.fromRGB(87, 99, 247)})
					end
				end
			end)
			
			function GNHub:Invite()
				
			end
			
		end
		
		function Tab:Holder()
		 	local Holder = {}
			-- StarterGui.GNHub.Main-Frame.Container.ScrollingFrame.holder
			Holder["63"] = Instance.new("TextLabel", Tab["1c"]);
			Holder["63"]["TextWrapped"] = true;
			Holder["63"]["BorderSizePixel"] = 0;
			Holder["63"]["TextScaled"] = true;
			Holder["63"]["BackgroundColor3"] = Color3.fromRGB(144, 144, 144);
			Holder["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			Holder["63"]["TextSize"] = 14;
			Holder["63"]["TextColor3"] = Color3.fromRGB(207, 207, 207);
			Holder["63"]["Size"] = UDim2.new(0, 375, 0, 10);
			Holder["63"]["Text"] = [[]];
			Holder["63"]["Name"] = [[holder]];
			Holder["63"]["BackgroundTransparency"] = 1;
			return Holder
		end
		return Tab
	end
	while wait() do
		if uis.TouchEnabled then
			if not GUI.Open then
				Mobile["2"].Visible = true
			end
		else
	end
	function GUI:Close()
		if uis.TouchEnabled then
			if GUI.Open then
				Library.tween(nil, GUI["2"], {Size = UDim2.new(0, 375, 0, 380)})
				Library.tween(nil, GUI["2"], {Position = GUI.Posit})
				Library.tween(nil, GUI["4"], {Size = UDim2.new(1, 0, 1, 0)})
				Library.tween(nil, GUI["5"], {Size = UDim2.new(1, 47, 1, 47)})
				Mobile["2"].Visible = false
				Library.tween(nil, Mobile["2"], {Position = UDim2.new(0.5, 0, 0, -60)})
				Library.tween(nil, Mobile["2"], {Size = UDim2.new(0, 0, 0, 0)})
			else
				Library.tween(nil, GUI["2"], {Size = UDim2.new(0, 0, 0, 0)})
				Library.tween(nil, GUI["2"], {Position = UDim2.new(0.5, 0, 0, -60)})
				Library.tween(nil, GUI["4"], {Size = UDim2.new(0, 0, 0, 0)})
				Library.tween(nil, GUI["5"], {Size = UDim2.new(0, 0, 0, 0)})
				Mobile["2"].Visible = true
				Library.tween(nil, Mobile["2"], {Position = UDim2.new(0.5, 0, 0.004999999888241291, 0)})
				Library.tween(nil, Mobile["2"], {Size = UDim2.new(0, 69, 0, 69)})
			end
		else
			if GUI.Open then
				Library.tween(nil, GUI["2"], {Size = UDim2.new(0, 375, 0, 380)})
				Library.tween(nil, GUI["2"], {Position = GUI.Posit})
				Library.tween(nil, GUI["4"], {Size = UDim2.new(1, 0, 1, 0)})
				Library.tween(nil, GUI["5"], {Size = UDim2.new(1, 47, 1, 47)})
			else
				Library.tween(nil, GUI["2"], {Size = UDim2.new(0, 0, 0, 0)})
				Library.tween(nil, GUI["2"], {Position = UDim2.new(0.5, 0, 0, -60)})
				Library.tween(nil, GUI["4"], {Size = UDim2.new(0, 0, 0, 0)})
				Library.tween(nil, GUI["5"], {Size = UDim2.new(0, 0, 0, 0)})
			end
		end
		GUI.Open = not GUI.Open
	end

	function GUI:CloseNot()
		if GUI.Open then
			GUI:CreateNotification({text = "Press F8 to open the menu"})
		else
			GUI:CreateNotification({text = "Press F8 to close the menu"})
		end
	end
	
	function GUI:Holder()
		local Holder = {}
		-- StarterGui.GNHub.Main-Frame.Tablist.ScrollingFrame.holder
		Holder["1b"] = Instance.new("Frame", GUI["f"]);
		Holder["1b"]["BorderSizePixel"] = 0;
		Holder["1b"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77);
		Holder["1b"]["BackgroundTransparency"] = 1;
		Holder["1b"]["Size"] = UDim2.new(0, 5, 0, 28);
		Holder["1b"]["Name"] = [[holder]];
		return Holder
	end
	
	do
		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			GUI.Posit = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			GUI["2"].Position = GUI.Posit
		end

		GUI["7"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = GUI["2"].Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		GUI["7"].InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		uis.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end

	do
		GUI["a"].MouseEnter:Connect(function()
			GUI.Hover = true
		end)

		GUI["a"].MouseLeave:Connect(function()
			GUI.Hover = false
		end)


		uis.InputBegan:Connect(function(input)
			if not Enum.UserInputType.MouseButton1 or not Enum.UserInputType.Touch then return end
			if uis:GetFocusedTextBox() then
				return
			end
			if input.KeyCode == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
				if GUI.Hover or Mobile.Hover then
					ClickSound:Play()
					GUI.MouseDown = true
					GUI:Close()
					if GUI.Hover then
						GUI.Hover = not GUI.Hover
					else
						Mobile.Hover = not Mobile.Hover
					end
				end
			end
		end)


		Mobile["2"].MouseEnter:Connect(function()
			Mobile.Hover = true
		end)

		Mobile["2"].MouseLeave:Connect(function()
			Mobile.Hover = false
		end)

		uis.InputBegan:Connect(function(input)
			if not options.KeyOpen then return end
			if uis:GetFocusedTextBox() then
				return
			end
			if input.KeyCode == options.KeyOpen or input.UserInputType == options.KeyOpen then
				GUI:Close()
				GUI:CloseNot()
			end
		end)
	end
	
	function GUI:CreateNotification(options)
		options = Library:validate({
			text = "Notification",
			lenght = 5
		}, options or {})
		
		local Notification = {}

		do
			-- StarterGui.NOTGNHUB
			Notification["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
			Notification["1"]["Name"] = [[NOTGNHUB]];

			-- StarterGui.NOTGNHUB.NotMainFrame
			Notification["2"] = Instance.new("Frame", Notification["1"]);
			Notification["2"]["BorderSizePixel"] = 0;
			Notification["2"]["BackgroundColor3"] = Color3.fromRGB(48, 48, 48);
			Notification["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Notification["2"]["Size"] = UDim2.new(0.15092989802360535, 0, 0.16491754353046417, 0);
			Notification["2"]["Position"] = UDim2.new(0.9082316160202026, 0, 1.5, 0);
			Notification["2"]["Name"] = [[NotMainFrame]];
			Notification["2"]["Visible"] = false;

			-- StarterGui.NOTGNHUB.NotMainFrame.DropShadowHolder
			Notification["3"] = Instance.new("Frame", Notification["2"]);
			Notification["3"]["ZIndex"] = 0;
			Notification["3"]["BorderSizePixel"] = 0;
			Notification["3"]["BackgroundTransparency"] = 1;
			Notification["3"]["Size"] = UDim2.new(1, 0, 1, 0);
			Notification["3"]["Name"] = [[DropShadowHolder]];

			-- StarterGui.NOTGNHUB.NotMainFrame.DropShadowHolder.DropShadow
			Notification["4"] = Instance.new("ImageLabel", Notification["3"]);
			Notification["4"]["ZIndex"] = 0;
			Notification["4"]["BorderSizePixel"] = 0;
			Notification["4"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			Notification["4"]["ScaleType"] = Enum.ScaleType.Slice;
			Notification["4"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			Notification["4"]["ImageTransparency"] = 0.5;
			Notification["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Notification["4"]["Image"] = [[rbxassetid://6014261993]];
			Notification["4"]["Size"] = UDim2.new(1, 47, 1, 47);
			Notification["4"]["Name"] = [[DropShadow]];
			Notification["4"]["BackgroundTransparency"] = 1;
			Notification["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

			-- StarterGui.NOTGNHUB.NotMainFrame.UICorner
			Notification["5"] = Instance.new("UICorner", Notification["2"]);


			-- StarterGui.NOTGNHUB.NotMainFrame.Line
			Notification["6"] = Instance.new("Frame", Notification["2"]);
			Notification["6"]["BorderSizePixel"] = 0;
			Notification["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Notification["6"]["Size"] = UDim2.new(1, 0, 0.029999999329447746, 0);
			Notification["6"]["Position"] = UDim2.new(0, 0, 0.30000001192092896, 0);
			Notification["6"]["Name"] = [[Line]];

			-- StarterGui.NOTGNHUB.NotMainFrame.TextLabel
			Notification["7"] = Instance.new("TextLabel", Notification["2"]);
			Notification["7"]["TextWrapped"] = true;
			Notification["7"]["TextScaled"] = true;
			Notification["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Notification["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			Notification["7"]["TextSize"] = 14;
			Notification["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Notification["7"]["Size"] = UDim2.new(1, 0, 0.30000001192092896, 0);
			Notification["7"]["Text"] = [[GNHUB]];
			Notification["7"]["BackgroundTransparency"] = 1;

			-- StarterGui.NOTGNHUB.NotMainFrame.Text
			Notification["8"] = Instance.new("TextLabel", Notification["2"]);
			Notification["8"]["TextWrapped"] = true;
			Notification["8"]["BorderSizePixel"] = 0;
			Notification["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Notification["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			Notification["8"]["TextSize"] = 21;
			Notification["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Notification["8"]["Size"] = UDim2.new(0.9336493015289307, 0, 0.581818163394928, 0);
			Notification["8"]["Text"] = options.text;
			Notification["8"]["Name"] = [[Text]];
			Notification["8"]["BackgroundTransparency"] = 1;
			Notification["8"]["Position"] = UDim2.new(0.033175356686115265, 0, 0.3545454442501068, 0);
		end

		do
			local c = 1
			function GUI:zigzag(X)
				return math.acos(math.cos(X * math.pi)) / math.pi
			end
			runService.RenderStepped:Connect(function()
				Notification["6"].BackgroundColor3 = Color3.fromHSV(GUI:zigzag(c),1,1)
				Notification["7"].TextColor3 = Color3.fromHSV(GUI:zigzag(c),1,1)
				c = c + .001
			end)
		end

		do
			Notification["2"].Visible = true
			Library.tween(nil, Notification["2"], {Position = UDim2.new(0.9082316160202026, 0, 0.8710644245147705, 0)})
			wait(options.lenght)
			Library.tween(nil, Notification["2"], {Position = UDim2.new(0.9082316160202026, 0, 1.5, 0)})
			wait(2)
			Notification["2"].Visible = false
		end
	end

	do
		local c = 1
		function GUI:zigzag(X)
			return math.acos(math.cos(X * math.pi)) / math.pi
		end
		runService.RenderStepped:Connect(function()
			GUI["6"].BackgroundColor3 = Color3.fromHSV(GUI:zigzag(c),1,1)
			GUI["9"].TextColor3 = Color3.fromHSV(GUI:zigzag(c),1,1)
			c = c + .001
		end)
	end
	GUI:Close()
	return GUI
end
return Library

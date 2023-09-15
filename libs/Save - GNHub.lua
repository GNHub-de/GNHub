local HttpService, ConfigGNHub = game:GetService("HttpService"), {}

ConfigGNHub.Encode = function(Table)
	assert(Table, "ConfigGNHub.Encode => Parameter \"Table\" is missing!")
	assert(type(Table) == "table", "ConfigGNHub.Encode => Parameter \"Table\" must be of type <table>. Type given: <"..type(Table)..">")

	if Table and type(Table) == "table" then
		return HttpService:JSONEncode(Table)
	end
end
ConfigGNHub.Decode = function(Content)
	assert(Content, "ConfigGNHub.Decode => Parameter \"Content\" is missing!")
	assert(type(Content) == "string", "ConfigGNHub.Decode => Parameter \"Content\" must be of type <string>. Type given: <"..type(Content)..">")

	return HttpService:JSONDecode(Content)
end

ConfigGNHub.Recursive = function(self, Table, Callback)
	assert(Table, "ConfigGNHub.Recursive => Parameter \"Table\" is missing!")
	assert(Callback, "ConfigGNHub.Recursive => Parameter \"Callback\" is missing!")
	assert(type(Table) == "table", "ConfigGNHub.Recursive => Parameter \"Table\" must be of type <table>. Type given: <"..type(Table)..">")
	assert(type(Callback) == "function", "ConfigGNHub.Recursive => Parameter \"Callback\" must be of type <string>. Type given: <"..type(Callback)..">")

	for i, v in next, Table do
		Callback(i, v)

		if type(v) == "table" then
			self:Recursive(v, Callback)
		end
	end
end

ConfigGNHub.EditValue = function(Value)
	if typeof(Value) == "Color3" then
		return "Color3_("..math.floor(Value.R * 255)..", "..math.floor(Value.G * 255)..", "..math.floor(Value.B * 255)..")"
	elseif typeof(Value) == "Vector3" or typeof(Value) == "Vector2" or typeof(Value) == "CFrame" then
		return typeof(Value).."_("..tostring(Value)..")"
	elseif typeof(Value) == "EnumItem" then
		return "EnumItem_("..string.match(tostring(Value), "Enum%.(.+)")..")"
	end

	return Value
end

ConfigGNHub.RestoreValue = function(Value)
	if type(Value) == "string" then
		local Type, Content = string.match(Value, "(%w+)_%((.+)%)")

		if Type == "Color3" then
			Content = string.split(Content, ", ")
			for i, v in next, Content do
				Content[i] = tonumber(v)
			end

			return Color3.fromRGB(unpack(Content))
		elseif Type == "Vector3" or Type == "Vector2" or Type == "CFrame" then
			Content = string.split(Content, ", ")

			for i, v in next, Content do
				Content[i] = tonumber(v)
			end

			return getfenv()[Type].new(unpack(Content))
		elseif Type == "EnumItem" then
			return loadstring("return Enum."..Content)()
		end
	end

	return Value
end

ConfigGNHub.CloneTable = function(self, Object, Seen)
	if type(Object) ~= "table" then return Object end
	if Seen and Seen[Object] then return Seen[Object] end

	local LocalSeen = Seen or {}
	local Result = setmetatable({}, getmetatable(Object))

	LocalSeen[Object] = Result

	for i, v in next, Object do
		Result[self:CloneTable(i, LocalSeen)] = self:CloneTable(v, LocalSeen)
	end

	return Result
end

ConfigGNHub.ConvertValues = function(self, Data, Method)
	assert(Data, "ConfigGNHub.ConvertValues => Parameter \"Data\" is missing!")
	assert(Method, "ConfigGNHub.ConvertValues => Parameter \"Method\" is missing!")
	assert(type(Data) == "table", "ConfigGNHub.ConvertValues => Parameter \"Data\" must be of type <table>. Type given: <"..type(Data)..">")
	assert(type(Method) == "string", "ConfigGNHub.ConvertValues => Parameter \"Method\" must be of type <string>. Type given: <"..type(Method)..">")

	local Passed, Stack = {[Data] = true}, {Data}

	repeat
		local Current = table.remove(Stack) -- "Pop"

		for i, v in next, Current do
			if type(v) == "table" and not Passed[v] then
				Passed[v] = true
				Stack[#Stack + 1] = v -- "Push" to stack
			else
				Current[i] = self[Method.."Value"](v)
			end
		end
	until #Stack == 0

	return Data
end

ConfigGNHub.SaveConfig = function(self, Path, Data)
	assert(Path, "ConfigGNHub.SaveConfig => Parameter \"Path\" is missing!")
	assert(Data, "ConfigGNHub.SaveConfig => Parameter \"Data\" is missing!")
	assert(type(Path) == "string", "ConfigGNHub.SaveConfig => Parameter \"Path\" must be of type <string>. Type given: <"..type(Path)..">")
	assert(type(Data) == "table", "ConfigGNHub.SaveConfig => Parameter \"Data\" must be of type <table>. Type given: <"..type(Data)..">")

	local Result = self.Encode(self:ConvertValues(self:CloneTable(Data), "Edit"))

	if select(2, pcall(function() readfile(Path) end)) then
		self.CreatePath(self, Path, Result)
	end

	writefile(Path, Result)
end

ConfigGNHub.LoadConfig = function(self, Path)
	assert(Path, "ConfigGNHub.LoadConfig => Parameter \"Path\" is missing!")
	assert(type(Path) == "string", "ConfigGNHub.LoadConfig => Parameter \"Path\" must be of type <string>. Type given: <"..type(Path)..">")

	return self:ConvertValues(self.Decode(readfile(Path)), "Restore")
end

ConfigGNHub.CreatePath = function(self, Path, Content)
	assert(Path, "ConfigGNHub.CreatePath => Parameter \"Path\" is missing!")
	assert(type(Path) == "string", "ConfigGNHub.CreatePath => Parameter \"Path\" must be of type <string>. Type given: <"..type(Path)..">")

	local Folders, Destination, File = string.split(Path, "/"), ""
	File = Folders[#Folders]; table.remove(Folders)

	for i = 1, #Folders do
		Destination = Destination..Folders[i].."/"

		if not isfolder(Destination) then
			makefolder(Destination)
		end
	end

	if not isfile(Destination..File) then
		writefile(Destination..File, Content or "")
	end
end

return ConfigGNHub
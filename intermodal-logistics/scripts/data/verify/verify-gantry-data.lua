---Takes the dev given table of gantry configuration and mutates it to be more useable.
---@param gantry table
---@return table
function verify_raw_gantry(gantry)
	local rotations = gantry.rotations;

	-- collect all the truck entries
	local ground_trucks = {
		table.unpack(rotations.north.ground_trucks),
		table.unpack(rotations.east.ground_trucks),
		table.unpack(rotations.south.ground_trucks or {}),
		table.unpack(rotations.west.ground_trucks or {}),
	};
	-- Get all the truck prototypes
	---@type {[table]: true} A Set of trucks
	local trucks_set = {};
	for i = 1, #ground_trucks, 1 do
		trucks_set[ground_trucks[i].truck] = true;
	end

	-- Convert from keys to values
	local trucks = {};
	local i = 1;
	for truck, _ in pairs(trucks_set) do
		truck.name = gantry.name .. "-truck-" .. tostring(i);
		table.insert(trucks, truck);
		i = i + 1;
	end

	-- Make sure gantry has flag not rotatable
	if(gantry.flags ~= nil and type(gantry.flags) == 'table') then
		local has_not_rotatable = false;
		for _, flag in ipairs(gantry.flags) do
			if(flag == "not-rotatable") then
				has_not_rotatable = true;
				break;
			end
		end
		if(not has_not_rotatable) then
			table.insert(gantry.flags, "not-rotatable");
		end
	else
		gantry.flags = {"not-rotatable"};
	end

	local data = {
		clone_north_to_south = rotations.south.ground_trucks == nil;
		clone_east_to_west = rotations.west.ground_trucks == nil;
		gantry_data = gantry;
		trucks = trucks;
	};
	return data;
end
---Takes the dev given table of gantry configuration and mutates it to be more useable.
---@param gantry table
---@return table
function verify_raw_gantry(gantry)
	local rotations = gantry.rotations;

	-- collect all the bogey entries
	local ground_bogies = {
		table.unpack(rotations.north.ground_bogies),
		table.unpack(rotations.east.ground_bogies),
		table.unpack(rotations.south.ground_bogies or {}),
		table.unpack(rotations.west.ground_bogies or {}),
	};
	-- Get all the bogey prototypes
	---@type {[table]: true} A Set of bogies
	local bogies_set = {};
	for i = 1, #ground_bogies, 1 do
		bogies_set[ground_bogies[i].bogey] = true;
	end

	-- Convert from keys to values
	local bogies = {};
	local i = 1;
	for bogey, _ in pairs(bogies_set) do
		bogey.name = gantry.name .. "-bogey-" .. tostring(i);
		table.insert(bogies, bogey);
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
		clone_north_to_south = rotations.south.ground_bogies == nil;
		clone_east_to_west = rotations.west.ground_bogies == nil;
		gantry_data = gantry;
		bogies = bogies;
	};
	return data;
end
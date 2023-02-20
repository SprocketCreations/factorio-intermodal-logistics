---Takes the dev given table of gantry configuration and mutates it to be more useable.
---@param raw_gantry table
---@return table
function verify_raw_gantry(raw_gantry)
	local rotations = raw_gantry.rotations;

	local north_bogeys = rotations.north.bogey and {rotations.north.bogey} or rotations.north.bogies;
	local east_bogeys  = rotations.east.bogey  and {rotations.east.bogey}  or rotations.east.bogies;
	local south_bogeys = rotations.south.bogey and {rotations.south.bogey} or rotations.south.bogies or {};
	local west_bogeys  = rotations.west.bogey  and {rotations.west.bogey}  or rotations.west.bogies or {};

	-- collect all the bogey entries
	local ground_bogies = {
		table.unpack(north_bogeys),
		table.unpack(east_bogeys),
		table.unpack(south_bogeys),
		table.unpack(west_bogeys),
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
		bogey.name = raw_gantry.name .. "-bogey-" .. tostring(i);
		table.insert(bogies, bogey);
		i = i + 1;
	end

	-- Make sure gantry has flag not rotatable
	if(raw_gantry.flags ~= nil and type(raw_gantry.flags) == 'table') then
		local has_not_rotatable = false;
		for _, flag in ipairs(raw_gantry.flags) do
			if(flag == "not-rotatable") then
				has_not_rotatable = true;
				break;
			end
		end
		if(not has_not_rotatable) then
			table.insert(raw_gantry.flags, "not-rotatable");
		end
	else
		raw_gantry.flags = {"not-rotatable"};
	end

	local data = {
		clone_north_to_south = rotations.south.ground_bogies == nil;
		clone_east_to_west = rotations.west.ground_bogies == nil;
		gantry = raw_gantry;
		bogies = bogies;
	};
	return data;
end
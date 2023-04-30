require("scripts.util.assert");
require("scripts.prototypes.gantry-prototype");
require("scripts.data.creation-helpers.create-bogey");
require("scripts.data.creation-helpers.create-gantry");
require("scripts.data.creation-helpers.create-gantry-placement-dummy");


---Writes a given rotation's data to the gantry prototype.
---@param data table The rotation of the gantry data returned from verify_raw_gantry to read from.
---@param rotation table The rotation of the gantry prototype to write to.
---@param prototype string The name of this rotation's prototype.
function write_data_to_rotation(data, rotation, prototype)
	rotation.prototype = prototype;

	local data_bogeys = data.bogies;
	for i = 1, #data_bogeys, 1 do
		table.insert(rotation.bogies, {
			prototype = data_bogeys[i].bogey.prototype,
			positions = data_bogeys[i].positions,
		});
	end
end

---Pulls the bogies array from a direction, while asserting that everything matches expected structure.
---@param rotations {}[]
---@param direction_key string
---@param assert_direction? boolean
---@return table[]
function get_and_assert_bogies(rotations, direction_key, assert_direction)
	assert_direction = assert_direction or false;
	local direction = rotations[direction_key];
	if (direction) then
		assert_type(direction, "table", "rotations." .. direction_key .. " must be a table");
		if (direction.bogies) then
			assert_type(direction.bogies, "table", "rotations." .. direction_key .. ".bogies must be a table");
			return direction.bogies;
		end
	elseif (assert_direction) then
		assert(false, "rotations." .. direction_key .. " is required");
	end
	return {};
end

---Parse and package a gantry prototype.
---@param gantry table The raw prototype provided to the mod.
function parse_gantry(gantry)
	assert(gantry.rotations, "rotations is required");
	assert_type(gantry.rotations, "table", "rotations must be a table");
	local rotations     = gantry.rotations;

	local north_bogeys  = get_and_assert_bogies(gantry.rotations, "north");
	local east_bogeys   = get_and_assert_bogies(gantry.rotations, "east");
	local south_bogeys  = get_and_assert_bogies(gantry.rotations, "south", true);
	local west_bogeys   = get_and_assert_bogies(gantry.rotations, "west", true);

	-- collect all the bogey entries
	local ground_bogies = {
		table.unpack(north_bogeys), table.unpack(east_bogeys),
		table.unpack(south_bogeys), table.unpack(west_bogeys),
	};
	-- Get all the bogey prototypes
	---@type {[table]: true} A Set of bogies
	local bogies_set    = {};
	for i = 1, #ground_bogies, 1 do
		assert_type(ground_bogies[i], "table", "bogies must be an array of tables");
		local bogey = ground_bogies[i].bogey;
		assert(bogey, "table", "bogey is required in each bogies entry");
		assert_type(bogey, "table", "bogey must be a table");
		bogies_set[bogey] = true;
	end

	-- Convert from keys to values
	local bogies = {};
	do
		local i = 1;
		for bogey, _ in pairs(bogies_set) do
			bogey.name = gantry.name .. "-bogey-" .. tostring(i);
			table.insert(bogies, bogey);
			i = i + 1;
		end
	end
	-- Make sure gantry has flag "not-rotatable"
	if (gantry.flags) then
		assert_type(gantry.flags, "table", "flags must be a table");
		local has_not_rotatable = false;
		for _, flag in ipairs(gantry.flags) do
			if (flag == "not-rotatable") then
				has_not_rotatable = true;
				break;
			end
		end
		if (not has_not_rotatable) then
			table.insert(gantry.flags, "not-rotatable");
		end
	else
		gantry.flags = { "not-rotatable" };
	end

	local clone_north_to_south = rotations.south.ground_bogies == nil;
	local clone_east_to_west = rotations.west.ground_bogies == nil;

	local placement_dummy_name = create_gantry_placement_dummy(gantry);
	local gantry_north_name, gantry_east_name, gantry_south_name, gantry_west_name = create_gantry(gantry);

	for i = 1, #bogies, 1 do
		bogies[i].prototype = create_bogey(bogies[i]);
	end

	assert(gantry.name, "name is required");
	assert_type(gantry.name, "string", "name must be a string");
	assert(gantry.work_width, "work_width is required");
	assert_type(gantry.work_width, "table", "work_width must be a table");
	assert_type(gantry.work_width[1], "number", "work_width must be a tuple of {number, number}");
	assert_type(gantry.work_width[2], "number", "work_width must be a tuple of {number, number}");
	local gantry_prototype = make_gantry_prototype(
		"gantry",
		gantry.name,
		placement_dummy_name,
		gantry.work_width,
		clone_north_to_south,
		clone_east_to_west
	);

	write_data_to_rotation(gantry.rotations.north, gantry_prototype.rotations.north, gantry_north_name);
	write_data_to_rotation(gantry.rotations.east, gantry_prototype.rotations.east, gantry_east_name);

	if (not clone_north_to_south) then
		write_data_to_rotation(gantry.rotations.south, gantry_prototype.rotations.south, gantry_south_name);
	end
	if (not clone_east_to_west) then
		write_data_to_rotation(gantry.rotations.west, gantry_prototype.rotations.west, gantry_west_name);
	end

	intermodal_logistics_pipeline:add_gantry_prototype(gantry_prototype);
end

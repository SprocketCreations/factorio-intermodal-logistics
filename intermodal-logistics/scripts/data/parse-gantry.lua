require("scripts.data.verify.verify-gantry-data");
require("scripts.data.creation-helpers.create-bogey");
require("scripts.data.creation-helpers.create-gantry");
require("scripts.data.creation-helpers.create-gantry-placement-dummy");

---Writes a given rotation's data to the gantry prototype.
---@param data table The rotation of the gantry data returned from verify_raw_gantry to read from.
---@param rotation table The rotation of the gantry prototype to write to.
---@param prototype string The name of this rotation's prototype.
function write_date_to_rotation(data, rotation, prototype)
	rotation.prototype = prototype;

	local data_bogeys = data.ground_bogeys;
	for i = 1, #data_bogeys, 1 do
		table.insert(rotation.bogeys, {
			prototype = data_bogeys[i].bogey.prototype,
			positions = data_bogeys[i].positions,
		});
	end
end

---Parse and package all the gantry prototypes.
---@param raw_gantry table The unqualified table provided to the mod.
function parse_gantry(raw_gantry)
	local data = verify_raw_gantry(raw_gantry);

	local gantry = data.gantry;
	local bogeys = data.bogeys;

	local placement_dummy_name = create_gantry_placement_dummy(gantry);
	local gantry_north_name, gantry_east_name, gantry_south_name, gantry_west_name = create_gantry(gantry);

	for i = 1, #bogeys, 1 do
		bogeys[i].prototype = create_bogey(bogeys[i]);
	end

	local gantry_prototype = make_gantry_prototype(placement_dummy_name, gantry.work_width, data.clone_north_to_south,
			data.clone_east_to_west);

	write_date_to_rotation(gantry.rotations.north, gantry_prototype.rotations.north, gantry_north_name);
	write_date_to_rotation(gantry.rotations.east, gantry_prototype.rotations.east, gantry_east_name);

	if (not data.clone_north_to_south) then
		write_date_to_rotation(gantry.rotations.south, gantry_prototype.rotations.south, gantry_south_name);
	end
	if (not data.clone_east_to_west) then
		write_date_to_rotation(gantry.rotations.west, gantry_prototype.rotations.west, gantry_west_name);
	end

	intermodal_logistics_pipeline:add_gantry_prototype(gantry_prototype);
end
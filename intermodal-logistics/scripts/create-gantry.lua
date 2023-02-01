require("scripts.create-gantry");

---Replaces a gantry dummy with its functional variant.
---@param entity_to_replace LuaEntity The entity to replace. This entity will be destroyed by this operation.
---@param gantry_data table The data to be used when constructing this gantry.
---@return table gantry_controller the gantry controller.
function create_gantry(entity_to_replace, gantry_data)
	---@type LuaSurface
	local surface = entity_to_replace.surface;

	local rotation_map = {
		[defines.direction.north] = "north";
		[defines.direction.east] = "east";
		[defines.direction.south] = "south";
		[defines.direction.west] = "west";
	};
	local rotation = rotation_map[entity_to_replace.direction];
	local data = gantry_data.rotations[rotation];
	local settings = {
		name = data.prototype;
		position = entity_to_replace.position,
		force = entity_to_replace.force,
		player = entity_to_replace.last_user.index,
		raise_built = true,
		create_build_effect_smoke = false,
		spawn_decorations = false,
		move_stuck_players = true,
	};

	entity_to_replace.destroy();
	local new_entity = surface.create_entity(settings);

	---@type LuaEntity[]
	local truck_entities = {};
	-- Create the trucks.
	for i = 1, #(data.trucks), 1 do
		local prototype = data.trucks.prototype;
		local positions = data.trucks.positions;
		for j = 1, #positions, 1 do
			local truck = surface.create_entity {
				name = prototype;
				position = positions[j];
				raise_built = false;
				create_build_effect_smoke = false,
				spawn_decorations = false,
				move_stuck_players = true,
			};
			table.insert(truck_entities, truck);
		end
	end

	return make_gantry_controller(new_entity, truck_entities);
end

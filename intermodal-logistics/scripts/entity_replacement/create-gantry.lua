
require("scripts.gantry-control.gantry-controller");

---Replaces a gantry dummy with its functional variant.
---@param gantry_dummy LuaEntity The entity to replace. This entity will be destroyed by this operation.
---@param gantry_prototype GantryPrototype The gantry prototype to be used when constructing this gantry.
function create_gantry(gantry_dummy, gantry_prototype)
	---@type LuaSurface
	local surface = gantry_dummy.surface;

	local rotation_map = {
		[defines.direction.north] = "north";
		[defines.direction.east] = "east";
		[defines.direction.south] = "south";
		[defines.direction.west] = "west";
	};
	local direction = gantry_dummy.direction;
	local rotation = rotation_map[direction];
	local data = gantry_prototype.rotations[rotation];
	local settings = {
		name = data.prototype;
		position = gantry_dummy.position,
		force = gantry_dummy.force,
		player = gantry_dummy.last_user.index,
		raise_built = true,
		create_build_effect_smoke = false,
		spawn_decorations = false,
		move_stuck_players = true,
	};

	gantry_dummy.destroy();
	local gantry_entity = surface.create_entity(settings);

	---@type LuaEntity[]
	local bogey_entities = {};
	-- Create the bogies.
	for i = 1, #(data.bogies), 1 do
		local prototype = data.bogies[i].prototype;
		local positions = data.bogies[i].positions;
		for j = 1, #positions, 1 do
			local bogey = surface.create_entity {
				name = prototype;
				position = {positions[j][1] + gantry_entity.position.x, positions[j][2] + gantry_entity.position.y};
				direction = direction;
				raise_built = false;
				create_build_effect_smoke = false,
				spawn_decorations = false,
				move_stuck_players = true,
			};
			table.insert(bogey_entities, bogey);
		end
	end

	global.gantry_controllers[gantry_entity.unit_number] =  make_gantry_controller(gantry_entity, bogey_entities);
end

-- Replaces a given entity with another.
-- No guarentees for switching prototypes
--that are wildly different.
-- This is ment for, and tested on cradles,
--gantries, and wagons. No guarentee it will
--work on other entities.
local replace_entity = function(entity, new_prototype)
	-- Stores all the data from the old
	--entity that needs to be restored.
	local old_entity = {
		surface = entity.surface,
		--default
		position = entity.position,
		direction = entity.direction,
		force = entity.force,
		player = entity.last_player,
		--container
		bar = entity.get_inventory(defines.inventory.chest).get_bar(),
		--rolling-stock
		orientation = entity.orientation,
		color = entity.color,
		--simple-entity
		render_player_index = entity.render_player.index,
	};

	local fast_replace = false;
	local spill = true;
	local raise_built = false;
	local create_build_effect_smoke = false;
	local spawn_decorations = true;
	local move_stuck_players = true;

	-- Make a new entity to replace the old one.
	local new_entity = old_entity.surface.create_entity {
		--all
		name = new_prototype,
		position = old_entity.position,
		direction = old_entity.direction,
		force = old_entity.force,
		fast_replace = fast_replace,
		player = old_entity.player,
		spill = spill,
		raise_built = raise_built;
		create_build_effect_smoke = create_build_effect_smoke,
		spawn_decorations = spawn_decorations,
		move_stuck_players = move_stuck_players,
		--item = nil,
		--container
		bar = old_entity.bar,
		--rolling-stock
		orientation = old_entity.orientation,
		color = old_entity.color,
		--simple-entity
		render_player_index = old_entity.render_player_index,
	};
	return new_entity;
end


return replace_entity;

-- Replaces a dummy cradle with its real version
function create_cradle(entity_to_replace, new_prototype)
	local surface = entity_to_replace.surface;
	local settings = {
		name = new_prototype,
		position = entity_to_replace.position,
		force = entity_to_replace.force,
		player = entity_to_replace.last_user.index,
		raise_built = true,
		create_build_effect_smoke = false,
		spawn_decorations = false,
		move_stuck_players = true,
	};

	entity_to_replace.destroy();
	local entity = surface.create_entity(settings);
	return entity;
end

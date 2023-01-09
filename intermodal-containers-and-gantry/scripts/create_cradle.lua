-- Replaces a dummy cradle with its real version
local create_cradle = function(dummy, new_prototype)
	local surface = dummy.surface;
	local settings = {
		name = new_prototype,
		position = dummy.position,
		force = dummy.force,
		player = dummy.last_user.index,
		raise_built = true,
		create_build_effect_smoke = false,
		spawn_decorations = false,
		move_stuck_players = true,
	};

	dummy.destroy();
	surface.create_entity(settings);
end

return create_cradle;
---Replaces a dummy dock with its real version
---@param entity_to_replace LuaEntity The dummy entity.
---@param new_prototype LargeContainerDockPrototype The dock prototype to use in instantiation.
---@return LuaEntity
function create_large_container_dock(entity_to_replace, new_prototype)
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
	if (entity == nil) then
		error("Large container dock failed to create.");
	end
	return entity;
end

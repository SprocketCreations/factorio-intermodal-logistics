-- Called when the player creates a new blueprint by dragging the selection tool.
function on_blueprint_setup(event)
	local player = game.get_player(event.player_index);
	-- Get a list of the entities that the player blueprinted
	local entities = player.cursor_stack.get_blueprint_entities();
	-- Get the blueprint item the player just created
	local blueprint = player.cursor_stack;
	-- We will keep track of all the docks here
	local dock_entities = {};
	-- Check each entity
	for _, entity in ipairs(entities) do
		-- Object is a ref to the registry entry for this entity, if this entity is in the registry
		local prototype = intermodal_logistics_game:get_prototype(entity.name);
		if (prototype ~= nil) then
			-- If it is registered, make a note of it.
			table.insert(dock_entities, {
				entity = entity,
				prototype = prototype,
			});
		end
	end

	-- If there are dock entities we need to modify,
	if (#dock_entities ~= 0) then
		-- First wipe the blueprints
		blueprint.clear_blueprint();
		-- Then iterate the list of entities we marked down as needing to be changed.
		for _, ent in pairs(dock_entities) do
			local entity = ent.entity;
			local object = ent.object;
			local dummy = object.placement_dummy_prototype_name;
			if (dummy ~= nil) then
				-- Depending on the prototype, we need to set the dummy rotation to either 4 or 2
				if (entity.name == object.empty_horizontal_prototype_name or entity.name == object.containered_horizontal_prototype_name) then
					entity.direction = 4; --hor
				else -- vertical
					entity.direction = 2; --vert
				end
				entity.name = dummy;
				-- Idk what variation is, but it showed up in the debugger as one, so I set it to one.
				entity.variation = 1;
			end
		end
		-- Write the updated list of entities back to the blueprint.
		blueprint.set_blueprint_entities(entities);
	end
end

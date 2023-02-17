require("scripts.gantry-control.gantry-socket");
require("scripts.create-cradle");
require("scripts.create-gantry");

---Called whenever an entity is created in the world.
---@param event EventData.on_built_entity | EventData.on_robot_built_entity
function on_build_entity(event)
	-- We access the global lookup table to check if the created entity is a registered prototype.
	local type = intermodal_logistics_game:get_type(event.created_entity.name);
	-- Lua does not have switch statements.
	local switch = {
		gantry = function()
			local gantry_prototype = intermodal_logistics_game:get_prototype(type);
			local player = game.get_player(event.player_index);

			local gantry_is_on_rails = gantry_prototype_check_for_rails(gantry_prototype, event.created_entity);
			local gantry_is_obstructed = not gantry_prototype_check_for_obstructions(gantry_prototype,
					event.created_entity);

			local number_of_rails_in_player_inventory = player.get_main_inventory().get_item_count("gantry-rail");
			local number_of_rails_needed = gantry_prototype_get_required_number_of_rails(gantry_prototype,
					event.created_entity.direction);
			local player_has_missing_rails = number_of_rails_in_player_inventory >= number_of_rails_needed;

			if (gantry_is_obstructed or ((not gantry_is_on_rails) and (not player_has_missing_rails))) then
				-- Play placement error sound.
				player.play_sound { path = "utility/cannot_build" };
				-- Spawn floating text telling player the problem.
				player.create_local_flying_text {
					text = gantry_is_obstructed and { "cant-build-reason.entity-in-the-way", "Entity" } or { "cant-build-reason.no-rails-for-gantry" },
					create_at_cursor = true,
					color = { 1, 1, 1, 1 },
				};
				-- Refund player item.
				-- Delete placed gantry.
				event.created_entity.destroy();
				return; -- EXIT EARLY
			end

			if ((not gantry_is_on_rails) and player_has_missing_rails) then
				-- Place rails from player's inventory under gantry.
				-- Spawn floating text telling player how many rails were placed.
			end

			create_gantry(event.created_entity, type);
		end,
		-- This is called if the entity is registered as a cradle
		-- cradle = function()
		-- 	local new_entity = event.created_entity;
		-- 	if (object.placement_dummy_prototype_name == event.created_entity.name) then
		-- 		-- The cradle has two steps:
		-- 		-- 1. replace dummy prototype with real prototype
		-- 		local direction = event.created_entity.direction;
		-- 		if (direction == defines.direction.east or direction == defines.direction.west) then
		-- 			--east
		-- 			new_entity = create_cradle(
		-- 				event.created_entity,
		-- 				object.empty_vertical_prototype_name);
		-- 		else
		-- 			--north
		-- 			new_entity = create_cradle(
		-- 				event.created_entity,
		-- 				object.empty_horizontal_prototype_name);
		-- 		end
		-- 	end
		-- 	-- 2. create and link socket object
		-- 	local socket = make_socket();
		-- 	global.sockets[new_entity.unit_number] = socket;
		-- end,
		-- -- This is called if the entity is registered as a flatbed
		-- flatbed = function()
		-- 	local socket = make_socket();
		-- 	global.sockets[event.created_entity.unit_number] = socket;
		-- end,
		-- -- This is called if the entity is registered as a cargoship
		-- cargoship = function()
		-- 	local socket = make_socket();
		-- 	global.sockets[event.created_entity.unit_number] = socket;
		-- end,
	};
	-- If the entity is registed as a socket
	if (type ~= nil) then
		-- Get its handler via the "switch" "statement"
		local handler = switch[type];
		if (handler == nil) then
			error("no handler found for socket type " + type);
			-- Only actually run the handler if this is the dummy.
		else
			handler();
		end
	end
end

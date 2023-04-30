require("scripts.gantry-control.gantry-socket");
require("scripts.entity-replacement.create-large-container-dock");
require("scripts.entity-replacement.create-gantry");

---Called whenever an entity is created in the world.
---@param event EventData.on_built_entity | EventData.on_robot_built_entity
function on_build_entity(event)
	-- We access the global lookup table to check if the created entity is a registered prototype.
	local custom_prototype = intermodal_logistics_game:get_prototype_by_associated_prototype(event.created_entity.name);

	---@type {[string]: fun()} Lua does not have switch statements.
	local switch = {
		gantry = function()
			---Rename and cast the variable.
			---@cast custom_prototype GantryPrototype
			local gantry_prototype = custom_prototype;

			local player = game.get_player(event.player_index);
			local gantry_is_on_rails = gantry_prototype_check_for_rails(gantry_prototype, event.created_entity);
			local gantry_is_obstructed = not gantry_prototype_check_for_obstructions(gantry_prototype,
				event.created_entity);

			local number_of_rails_in_player_inventory = player.get_main_inventory().get_item_count("gantry-rail");
			local number_of_rails_needed = gantry_prototype_get_required_number_of_rails(gantry_prototype,
				event.created_entity.direction);
			local player_has_missing_rails = number_of_rails_in_player_inventory >= number_of_rails_needed;

			local function reject_placement()
				-- Play placement error sound.
				player.play_sound { path = "utility/cannot_build" };
				-- Spawn floating text telling player the problem.
				player.create_local_flying_text {
					text = gantry_is_obstructed and { "cant-build-reason.entity-in-the-way", "Entity" } or
						{ "cant-build-reason.no-rails-for-gantry" },
					create_at_cursor = true,
					color = { 1, 1, 1, 1 },
				};
				-- Refund player item.
				-- Delete placed gantry.
				event.created_entity.destroy();
			end

			local function try_place_rails()
				-- Place rails from player's inventory under gantry.

				-- Spawn floating text telling player how many rails were placed.
				player.create_local_flying_text {
					text = { "gantry-help.rails-placed", number_of_rails_needed },
					create_at_cursor = true,
					color = { 1, 1, 1, 1 },
				};

				return true;
			end

			-- If the gantry cannot be placed in the first place.
			if (gantry_is_obstructed) then
				reject_placement();
				-- If it can be placed.
			elseif (gantry_is_on_rails) then
				create_gantry(event.created_entity, gantry_prototype);
				-- If it needs rails.
			else
				-- If the player has those rails.
				if (player_has_missing_rails) then
					-- Try to place those rails
					if (try_place_rails()) then
						create_gantry(event.created_entity, gantry_prototype);
						-- Those rails could not be placed for some reason.
					else
						reject_placement();
					end
					-- If the player does not have those rails.
				else
					reject_placement();
				end
			end
		end,
		-- This is called if the entity is registered as a dock
		-- ["large_container_dock"] = function()
		-- 	local new_entity = event.created_entity;
		-- 	if (object.placement_dummy_prototype_name == event.created_entity.name) then
		-- 		-- The dock has two steps:
		-- 		-- 1. replace dummy prototype with real prototype
		-- 		local direction = event.created_entity.direction;
		-- 		if (direction == defines.direction.east or direction == defines.direction.west) then
		-- 			--east
		-- 			new_entity = create_dock(
		-- 				event.created_entity,
		-- 				object.empty_vertical_prototype_name);
		-- 		else
		-- 			--north
		-- 			new_entity = create_dock(
		-- 				event.created_entity,
		-- 				object.empty_horizontal_prototype_name);
		-- 		end
		-- 	end
		-- 	-- 2. create and link socket object
		-- 	local socket = make_socket();
		-- 	global.sockets[new_entity.unit_number] = socket;
		-- end,
		-- -- This is called if the entity is registered as a flatbed
		-- ["container_wagon"] = function()
		-- 	local socket = make_socket();
		-- 	global.sockets[event.created_entity.unit_number] = socket;
		-- end,
		-- -- This is called if the entity is registered as a cargoship
		-- ["container-ship"] = function()
		-- 	local socket = make_socket();
		-- 	global.sockets[event.created_entity.unit_number] = socket;
		-- end,
	};
	-- If the entity is registed as a socket
	if (type ~= nil) then
		---@type fun() Get its handler via the "switch" "statement"
		local handler = switch[type];
		if (handler == nil) then
			-- Only actually run the handler if we have one.
			error("no configuration handler found for custom type " + type);
		else
			handler();
		end
	end
end

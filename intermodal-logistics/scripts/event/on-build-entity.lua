require("scripts.gantry-control.gantry-socket");
require("scripts.create-cradle");

-- Called whenever an entity is created in the world.
function on_build_entity(event)
	-- We access the global lookup table to check if the created entity is registered as a socket.
	local object = intermodal_logistics:get_data(event.created_entity.name);
	if (object == nil) then
		object = gantry_prototype.socket_prototypes[event.created_entity.name];
	end
	-- Lua does not have switch statements to my knowledge.
	local switch = {
		gantry = function()
			global.gantries = create_gantry(event.created_entity, object);
		end,
		-- This is called if the entity is registered as a cradle
		cradle = function()
			local new_entity = event.created_entity;
			if (object.placement_dummy_prototype_name == event.created_entity.name) then
				-- The cradle has two steps:
				-- 1. replace dummy prototype with real prototype
				local direction = event.created_entity.direction;
				if (direction == defines.direction.east or direction == defines.direction.west) then
					--east
					new_entity = create_cradle(
						event.created_entity,
						object.empty_vertical_prototype_name);
				else
					--north
					new_entity = create_cradle(
						event.created_entity,
						object.empty_horizontal_prototype_name);
				end
			end
			-- 2. create and link socket object
			local socket = make_socket();
			global.sockets[new_entity.unit_number] = socket;
		end,
		-- This is called if the entity is registered as a flatbed
		flatbed = function()
			local socket = make_socket();
			global.sockets[event.created_entity.unit_number] = socket;
		end,
		-- This is called if the entity is registered as a cargoship
		cargoship = function()
			local socket = make_socket();
			global.sockets[event.created_entity.unit_number] = socket;
		end,
	};
	-- If the entity is registed as a socket
	if (object ~= nil) then
		-- Get its handler via the "switch" "statement"
		local handler = switch[object.type];
		if (handler == nil) then
			error("no handler found for socket type " + object.type);
			-- Only actually run the handler if this is the dummy.
		else
			handler();
		end
	end
end
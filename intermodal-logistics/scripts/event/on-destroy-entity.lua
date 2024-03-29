-- Called whenever an entity is removed from the world,
-- either via mining or death.
function on_destroy_entity(event)
	-- We access the global lookup table to check if the destroyed entity is registered as a socket.
	local prototype = intermodal_logistics_game:get_prototype_by_name(event.entity.name);
	-- Lua does not have switch statements to my knowledge.
	local switch = {
		gantry = function()
			gantry_controller_destroy(global.gantry_controllers[event.entity.unit_number]);
			global.gantry_controllers[event.entity.unit_number] = nil;
		end,
		-- This is called if the entity is registered as a dock
		["large-container-dock"] = function()
			global.sockets[event.entity.unit_number] = nil;
		end,
		-- This is called if the entity is registered as a flatbed
		["container-wagon"] = function()
			global.sockets[event.entity.unit_number] = nil;
		end,
		-- This is called if the entity is registered as a cargoship
		["container-ship"] = function()
			global.sockets[event.entity.unit_number] = nil;
		end,
	};
	-- If the entity is registed as a socket
	if (prototype ~= nil) then
		-- Get its handler via the "switch" "statement"
		local handler = switch[prototype.type];
		if (handler == nil) then
			error("no handler found for socket type " + prototype.type);
		else
			handler();
		end
	end
end

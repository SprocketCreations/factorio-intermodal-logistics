-- Called whenever an entity is removed from the world,
-- either via mining or death.
local on_destroy_entity = function(event)
	-- We access the global lookup table to check if the destroyed entity is registered as a socket.
	local object = gantry_prototype.socket_prototypes[event.entity.name];
	-- Lua does not have switch statements to my knowledge.
	local switch = {
		-- This is called if the entity is registered as a cradle
		cradle = function()
			global.sockets[event.entity] = nil;
		end,
		-- This is called if the entity is registered as a flatbed
		flatbed = function()
			global.sockets[event.entity] = nil;
		end,
		-- This is called if the entity is registered as a cargoship
		cargoship = function()
			global.sockets[event.entity] = nil;
		end,
	};
	-- If the entity is registed as a socket
	if (object ~= nil) then
		-- Get its handler via the "switch" "statement"
		local handler = switch[object.type];
		if (handler == nil) then
			error("no handler found for socket type " + object.type);
		else
			handler();
		end
	end
end

return on_destroy_entity;

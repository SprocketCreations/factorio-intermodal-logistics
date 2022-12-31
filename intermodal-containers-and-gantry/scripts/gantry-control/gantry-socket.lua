
-- This is a constructor for a socket.
-- A socket is a representation of a
--cradle or a flatbed wagon.
local makeSocket = function ()
	local socket = {};

	-- This is the ingame time when a container
	--was last removed from this socket
	socket.timeEmptied = 0;

	-- This is a count of the number of times this
	--socket was skipped by the gantry mind while
	--waiting to have its container removed
	socket.timesSkipped = 0;

	-- Returns a sorted array of all the items
	--requested by this socket.
	function socket:getFilters()
		local filters = {};

		-- TODO: Implement

		table.sort(filters);
		return filters;
	end

	-- Returns a sorted array of all the items
	--offered by this socket.
	function socket:getItems()
		local items = {};

		-- TODO: implement

		table.sort(items);
		return items;
	end

	-- Returns true if this socket has a container.
	function socket:hasContainer()
		-- TODO: implement
		return false;
	end

	-- Returns true if this socket's remove conditions
	--are met.
	-- Note: does not check if a container if present.
	-- Call hasContainer() before this to know for
	--certain.
	function socket:meetsConditions()
		-- TODO: implement
		return false;
	end

	return socket;
end




return makeSocket();
require("gantry-socket-conditions");

-- Sets the filter at the given index.
function socket_set_filter(socket, index, filter)
	socket.filters[index] = filter;
end

-- Returns the set filter at a given index.
-- Returns nil if there is no filter set.
function socket_get_filter(socket, index)
	return socket.filters[index];
end

-- Returns a sorted array of all the items
--requested by this socket.
function socket_set_filters(socket)
	-- Loop over all the entries in the socket.filters
	--table and add them to this local filters array.
	local filters = {};
	for _, filter in socket.filters do
		-- Skip the entry if it is an empty slot
		if (filter ~= nil) then
			filters.insert(filter);
		end
	end

	-- Sort the local filters table alphabetically.
	table.sort(filters);

	-- Remove duplicates from local filters and
	--write that output to local filtersSet.
	local filters_set = {};
	local last_filter_written = nil;
	for _, filter in filters do
		if (last_filter_written ~= filter) then
			filters_set.insert(filter);
			last_filter_written = filter;
		end
	end

	return filters_set;
end

-- Returns true if this socket has a container.
function socket_has_container(socket)
	return socket.containered;
end

-- Returns a sorted array of all the items
--offered by this socket.
function socket_get_items(socket)
	if (socket_has_container(socket)) then
		local items = {};

		-- TODO: implement

		table.sort(items);
		return items;
	else
		return {};
	end
end

-- Returns true if this socket's remove conditions
--are met.
-- Note: does not check if a container if present.
-- Call socket_has_container(socket) before this to know for
--certain.
function socket_meets_conditions(socket)
	return conditional_meets_conditions(socket.conditionals, socket.entity);
end

-- This is a constructor for a socket.
-- A socket is a representation of a
--cradle or a flatbed wagon.
function make_socket(entity)
	local socket = {};

	-- Reference to the socket entity in the world.
	socket.entity = entity;

	-- Bool. Stores whether this socket has an
	--intermodal container in it.
	socket.containered = false;

	-- Collection of all the filters set on this socket.
	socket.filters = {};

	-- The Conditionals on this socket
	socket.conditionals = make_conditional();

	-- This is the ingame time when a container
	--was last removed from this socket.
	socket.time_emptied = 0;

	-- This is a count of the number of times this
	--socket was skipped by the gantry mind while
	--waiting to have its container removed.
	socket.times_skipped = 0;

	return socket;
end

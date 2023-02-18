require("gantry-socket-conditions");

-- Sets the filter at the given index.
---@param socket Socket self.
---@param index number
---@param filter string The filter to set.
function socket_set_filter(socket, index, filter)
	socket.filters[index] = filter;
end

---@param socket Socket self.
---@param index number
---@return string | nil # the set filter at a given index or nil if there is no filter set.
function socket_get_filter(socket, index)
	return socket.filters[index];
end

---@param socket Socket self.
---@return string[] # a sorted array of all the items requested by this socket.
function socket_get_filters(socket)
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

---@param socket Socket self.
---@return boolean # true if this socket has a container.
function socket_has_container(socket)
	return socket.has_container;
end

-- Returns a sorted array of all the items offered by this socket.
---@param socket Socket self.
---@return string[] # Sorted names of the items in this container with no duplicates.
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

---Note: does not check if a container if present.
---
---Call socket_has_container(socket) before this to know for certain.
---@param socket Socket self.
---@return boolean # true if this socket's remove conditions are met.
function socket_meets_conditions(socket)
	return socket_conditional_meets_conditions(socket.conditionals, socket.entity);
end

---@class Socket
---@field entity LuaEntity Reference to the socket entity in the world.
---@field has_container boolean Stores whether this socket has an intermodal container in it.
---@field filters string[] Collection of all the filters set on this socket.
---@field conditionals SocketConditional
---@field time_emptied number Current tick when a container was last removed from this socket.
---@field times_skipped number The number of times this socket was skipped by the cluster while waiting to have its container removed.

-- This is a constructor for a socket.
-- A socket is a representation of a dock or a flatbed wagon.
---@param entity LuaEntity
---@return Socket
function make_socket(entity)
	---@type Socket
	local socket = {
		entity = entity;
		has_container = false;
		filters = {};
		conditionals = make_socket_conditional();
		time_emptied = 0;
		times_skipped = 0;
	};

	return socket;
end

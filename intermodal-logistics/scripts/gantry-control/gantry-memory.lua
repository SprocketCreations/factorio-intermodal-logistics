require("gantry-socket");

-- This redetermines the placement of the
--sockets in the above tables.
function memory_refresh_socket_categorization(memory)
	-- First clear the tables
	memory.empty_sockets = {};
	memory.finished_sockets = {};
	-- Then for each socket the gantry can access
	for _, socket in memory.sockets do
		-- If it has not a container
		if (socket_has_container(socket) == false) then
			memory.empty_sockets.insert(socket);
			-- If it has a container that can be removed
		elseif (socket_meets_conditions(socket)) then
			memory.finished_sockets.insert(socket);
		end
	end
	local sort_emptied = function(socket1, socket2)
		return socket1.time_emptied < socket2.time_emptied;
	end

	local sort_finished = function(socket1, socket2)
		return socket1.times_skipped > socket2.times_skipped;
	end

	-- Sort the sockets according to wait time
	table.sort(memory.empty_sockets, sort_emptied);
	table.sort(memory.finished_sockets, sort_finished);
end

function make_memory()
	local memory = {};

	--[[ The tables stored in the memory ]] --
	-- This is a collection of all the
	--sockets that this gantry cluster can see
	memory.sockets = {};
	-- This is a collection of all the empty
	--sockets that the gantry cluster has access to
	memory.empty_sockets = {};
	-- This is a collection of all the
	--sockets that have containers, but meet
	--the requirements to be unloaded
	memory.finished_sockets = {};

	return memory;
end

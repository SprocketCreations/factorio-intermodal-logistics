require("gantry-memory");
require("gantry-task");
require("gantry-socket");

-- Generates a series of tasks and calls callback on each one.
-- If callback likes the task it can return true.
-- If callback returns false, a new task will be generated.
-- If a task is accepted, findTask will return true.
-- If no task is accepted, findTask will return false.
function mind_find_task(mind, callback)
	-- For each waiting empty socket
	for _, empty_socket in mind.memory.empty_sockets do
		-- Check each finished socket
		for _, finished_socket in mind.memory.finished_sockets do
			-- TODO: Upgrade this to use hashing.
			-- Function that checks if a filter and item array match.
			-- The two collections MUST be sorted alphabetically.
			local match = function(filters, items)
				-- Different lengths, we know they will not match
				if(#filters ~= #items) then return false; end
				for i, filter in filters do
					-- Items dont match
					if(filter ~= items[i]) then
						return false;
					end
				end
				return true;
			end
			-- get emptySocket filters
			local filters = socket_get_filter(empty_socket);
			-- get items that finishedSocket has
			local items = socket_get_items(finished_socket);
			-- if they match, then this is a task
			if(match(filters, items)) then
				local task = make_task(finished_socket, empty_socket);
				local good = callback(task);
				-- If this task is accepted, then we are done
				if(good) then
					return true;
				end
			end
			-- Otherwise we need to find a better task
		end
	end
	return false;
end

-- Checks all the idle gantries to see if one
--can complete a given task, and return its index.
-- If no gantry is found, return -1.
function mind_find_gantry(mind, task)
	for i, gantry in mind.idle_gantries do
		if(gantry_controller_can_complete_task(gantry, task)) then
			return i;
		end
	end
	return -1;
end

-- This function tries to give orders to all of
--its idle gantries.
function mind_determine_tasks(mind)
	-- Until there are no more wating gantries
	--or there are no tasks found
	while #mind.idle_gantries do
		-- Find the next potential task
		local was_a_task_found = mind_find_task(mind, function(task)
			-- If a gantry can fulfill this task
			local gantry_index = mind_find_gantry(mind, task);
			local gantry = mind.idle_gantries[gantry_index];
			if(gantry ~= nil) then
				-- Issue the order to the gantry
				gantry.give_order(task);

				-- Remove this gantry from the idle collection,
				--as it now has a task to perform.
				mind.idle_gantries.remove(gantry_index);
				return true;
			end
			return false;
		end);

		-- We have no tasks to give, so the remaining
		--idle gantries will just have to sit idle longer.
		if(!was_a_task_found) then
			return;
		end
	end
end

-- Constructor for a gantry cluster.
-- This object manages multiple gantries in a cluster.
function make_gantry_cluster()
	local mind = {};
	
	-- This is information about what sockets
	--the gantry collective has access to.
	mind.memory = make_memory();

	-- These are the gantries not currently doing anything.
	-- Sorted according to how long the gantry has been wating
	--for an order.
	mind.idle_gantries = {};

	return mind;
end

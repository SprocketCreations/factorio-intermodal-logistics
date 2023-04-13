require("gantry-memory");
require("gantry-task");
require("gantry-socket");

---Generates a series of tasks and calls callback on each one.
---@param cluster GantryCluster self.
---@param callback fun(task: GantryTask): boolean Called for each task generated. Return true to accept the task.
---@return boolean # Whether a task was accepted or not.
function gantry_cluster_find_task(cluster, callback)
	-- For each waiting empty socket
	for _, empty_socket in ipairs(cluster.empty_sockets) do
		-- Check each finished socket
		for _, finished_socket in ipairs(cluster.finished_sockets) do
			-- TODO: Upgrade this to use hashing.
			---Checks if a filter and item array match.
			---
			---The two collections MUST be sorted alphabetically.
			---@param filters string[] Array of filters.
			---@param items string[] Array of items.
			---@return boolean # Whether the tables match.
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
				local task = make_gantry_task(finished_socket, empty_socket);
				local good = callback(task);
				-- If this task is accepted, then we are done.
				if(good) then
					return true;
				end
			end
			-- Otherwise we need to find a better task.
		end
	end
	-- No task was accepted.
	return false;
end

-- Checks all the idle gantries to see if one can complete a given task.
---@param cluster GantryCluster self.
---@param task GantryTask The task needing a gantry.
---@return number # the index of the gantry found that can complete the task, or -1 if none were found.
function gantry_cluster_find_gantry_for_task(cluster, task)
	for i, gantry in ipairs(cluster.idle_gantries) do
		if(gantry_controller_can_complete_task(gantry, task)) then
			return i;
		end
	end
	-- No gantry was found, so return -1.
	return -1;
end

-- This function tries to give orders to all of
--its idle gantries.
---@param cluster GantryCluster
function gantry_cluster_determine_tasks(cluster)
	-- Until there are no more wating gantries
	--or there are no tasks found
	while #cluster.idle_gantries do
		-- Find the next potential task
		local was_a_task_found = gantry_cluster_find_task(cluster, function(task)
			-- If a gantry can fulfill this task
			local gantry_index = gantry_cluster_find_gantry_for_task(cluster, task);
			if(gantry_index ~= -1) then
				local gantry = cluster.idle_gantries[gantry_index];
				-- Issue the order to the gantry
				gantry_give_task(gantry, task);

				-- Remove this gantry from the idle collection,
				--as it now has a task to perform.
				table.remove(cluster.idle_gantries, gantry_index);
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

-- This redetermines the placement of the sockets in the member tables.
---@param cluster GantryCluster self.
function gantry_cluster_refresh_socket_categorization(cluster)
	-- First clear the tables
	cluster.empty_sockets = {};
	cluster.finished_sockets = {};
	-- Then for each socket the gantry can access
	for _, socket in ipairs(cluster.sockets) do
		-- If it has not a container
		if (socket_has_container(socket) == false) then
			table.insert(cluster.empty_sockets, socket);
		-- If it has a container that can be removed
		elseif (socket_meets_conditions(socket)) then
			table.insert(cluster.finished_sockets, socket);
		end
	end
	---Sorting predicate for how long the socket has sat empty.
	---@param socket1 ContainerSocket
	---@param socket2 ContainerSocket
	---@return boolean # if socket2 has sat idle longer than socket1.
	local sort_emptied = function(socket1, socket2)
		return socket1.time_emptied < socket2.time_emptied;
	end

	---Sorting predicate for how many times the socket has been skipped over by the cluster.
	---@param socket1 ContainerSocket
	---@param socket2 ContainerSocket
	---@return boolean # if socket1 has been skipped more times than socket2.
	local sort_finished = function(socket1, socket2)
		return socket1.times_skipped > socket2.times_skipped;
	end

	-- Sort the sockets according to wait time
	table.sort(cluster.empty_sockets, sort_emptied);
	table.sort(cluster.finished_sockets, sort_finished);
end

---@class GantryCluster
---@field gantries GantryController[] All gantries controlled by this cluster.
---@field idle_gantries GantryController[] These are the gantries not currently doing anything. Sorted according to how long the gantry has been wating for an order.
---@field sockets ContainerSocket[] All the sockets that this gantry cluster can see.
---@field empty_sockets ContainerSocket[] All the empty sockets that the gantry cluster has access to.
---@field finished_sockets ContainerSocket[] All the sockets that have containers, but meet the requirements to be unloaded.

-- Constructor for a gantry cluster.
-- This object manages multiple gantries in a cluster.
---@return GantryCluster
function make_gantry_cluster()
	---@type GantryCluster
	local gantry_cluster = {
		gantries = {};
		idle_gantries = {};

		sockets = {};
		empty_sockets = {};
		finished_sockets = {};
	};

	return gantry_cluster;
end

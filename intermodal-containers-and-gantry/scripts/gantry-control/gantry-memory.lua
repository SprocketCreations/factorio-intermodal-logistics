local memory = {};

--[[ The tables stored in the memory ]]--
-- This is the action performed by the
--gantry right now
memory.currentTask = {};
-- This is a collection of all the
--sockets that this gantry can see
memory.sockets = {};
-- This is a collection of all the empty
--sockets that the gantry has access to
memory.emptySockets = {};
-- This is a collection of all the
--sockets that have containers, but meet
--the requirements to be unloaded
memory.finishedSockets = {};

-- This redetermines the placement of the
--sockets in the above tables.
function memory:refreshSocketCategorization()
	-- First clear the tables
	self.emptySockets = {};
	self.finishedSockets = {};
	-- Then for each socket the gantry can access
	for _, socket in self.sockets do
		-- If it has not a container
		if(socket:hasContainer() == false) then
			self.emptySockets.insert(socket);
		-- If it has a container that can be removed
		elseif(socket:meetsConditions()) then
			self.finishedSockets.insert(socket);
		end
	end
	local sortEmptied = function(socket1, socket2)
		return socket1.timeEmptied < socket2.timeEmptied;
	end

	local sortFinished = function(socket1, socket2)
		return socket1.timesSkipped > socket2.timesSkipped;
	end

	-- Sort the sockets according to wait time
	table.sort(self.emptySockets, sortEmptied);
	table.sort(self.finishedSockets, sortFinished);
end

return memory;

-- Constructor for a task.
-- Takes startingSocket as the socket that has the container
-- Takes endingSocket as the socket that wants the container
local makeTask = function (startingSocket, endingSocket)
	local task = {};
	
	task.startingSocket = startingSocket;
	task.endingSocket = endingSocket;

	return task;
end

return makeTask;
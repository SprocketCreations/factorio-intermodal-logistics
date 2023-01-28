
-- Constructor for a task.
-- Takes startingSocket as the socket that has the container
-- Takes endingSocket as the socket that wants the container
function make_task(starting_socket, ending_socket)
	local task = {};
	
	task.starting_socket = starting_socket;
	task.ending_socket = ending_socket;

	return task;
end

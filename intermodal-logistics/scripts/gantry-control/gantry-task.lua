---@class GantryTask
---@field starting_socket ContainerSocket
---@field ending_socket ContainerSocket

---Constructor for a GantryTask.
---@param starting_socket ContainerSocket The socket that has the container.
---@param ending_socket ContainerSocket The socket that wants the container.
---@return GantryTask
function make_gantry_task(starting_socket, ending_socket)
	---@type GantryTask
	local task = {
		starting_socket = starting_socket;
		ending_socket = ending_socket;
	};

	return task;
end

---@class GantryTask
---@field starting_socket Socket
---@field ending_socket Socket

---Constructor for a GantryTask.
---@param starting_socket Socket The socket that has the container.
---@param ending_socket Socket The socket that wants the container.
---@return GantryTask
function make_gantry_task(starting_socket, ending_socket)
	---@type GantryTask
	local task = {
		starting_socket = starting_socket;
		ending_socket = ending_socket;
	};

	return task;
end

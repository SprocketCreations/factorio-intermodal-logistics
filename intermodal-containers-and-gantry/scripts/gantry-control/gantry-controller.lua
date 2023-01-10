

-- Constructor for a gantry controller.
-- This object manages a single gantry in the world.
-- It can be given tasks and will act on them.
local make_gantry_controller = function(entity)
	local gantry_controller = {};

	-- Reference to the entity in the world
	--that represents this gantry crane.
	gantry_controller.entity = entity;

	-- This is the action performed by the
	--gantry right now
	gantry_controller.current_task = {};

	-- Returns a rectangle representing the area
	--the gantry has access to.
	function gantry_controller:get_work_area()
		-- TODO: implement
		return nil;
	end

	-- Function to test if a gantry is capable of
	--completing a given task.
	-- Returns true if both sockets are within
	--the gantry's work area.
	function gantry_controller:can_complete_task(task)
		

		return true;
	end

	return gantry_controller;
end

return make_gantry_controller;


-- Constructor for a gantry controller.
-- This object manages a single gantry in the world.
-- It can be given tasks and will act on them.
local makeGantryController = function()
	local gantryController = {};

	-- Returns a rectangle representing the area
	--the gantry has access to.
	function gantryController:getWorkArea()
		-- TODO: implement
		return nil;
	end

	-- Function to test if a gantry is capable of
	--completing a given task.
	-- Returns true if both sockets are within
	--the gantry's work area.
	function gantryController:canCompleteTask(task)
		

		return true;
	end

	return gantryController;
end

return makeGantryController;
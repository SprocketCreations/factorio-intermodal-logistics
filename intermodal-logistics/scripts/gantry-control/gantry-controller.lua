-- Returns a rectangle representing the area
--the gantry has access to.
function gantry_controller_get_work_area(gantry_controller)
	-- TODO: implement
	return nil;
end

-- Function to test if a gantry is capable of
--completing a given task.
-- Returns true if both sockets are within
--the gantry's work area.
function gantry_controller_can_complete_task(gantry_controller, task)


	return true;
end

---@class GantryController
---@field entity LuaEntity The entity in the world that represents this gantry crane.
---@field trucks LuaEntity[] This gantry's trucks.
---@field current_task GantryTask[] This is the action performed by the gantry right now.

---Constructor for a gantry controller.
---This object manages a single gantry in the world.
---It can be given tasks and will act on them.
---@param gantry_entity LuaEntity The gantry entity.
---@param truck_entities LuaEntity[] All the truck entities owned by this gantry.
---@return GantryController gantry_controller
function make_gantry_controller(gantry_entity, truck_entities)
	---@type GantryController
	local gantry_controller = {
		entity = gantry_entity;
		trucks = truck_entities;
		current_task = {};
	};

	return gantry_controller;
end

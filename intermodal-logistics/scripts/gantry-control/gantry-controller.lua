require("scripts.util.bounding-box");

---@class GantryController
---@field prototype string The custom intermodal logistics prototype.
---@field rotation string The rotation of this gantry.
---@field work_area BoundingBox The area that this gantry can service.
---@field current_task GantryTask | nil This is the action performed by the gantry right now.
---Entities:
---@field entity LuaEntity The entity in the world that represents this gantry crane.
---@field bogies LuaEntity[] This gantry's bogey entities.
---Render objects:
---@field trolley_render_object_id uint64 The id of the trolley's lua render object.
---@field turntable_render_object_id uint64 The id of the turntable's lua render object.
---@field claw_render_object_id uint64 The id of the claw's lua render object.

---Constructor for a gantry controller.
---
---This object manages a single gantry in the world.
---It can be given tasks and will act on them.
---@param gantry_prototype GantryPrototype The gantry prototype.
---@param gantry_entity LuaEntity The gantry entity.
---@param bogey_entities LuaEntity[] All the bogey entities owned by this gantry.
---@return GantryController gantry_controller
function make_gantry_controller(gantry_prototype, gantry_entity, bogey_entities)
	local get_rotation = {
		[defines.direction.north] = "north",
		[defines.direction.east] = "east",
		[defines.direction.south] = "south",
		[defines.direction.west] = "west",
	};

	---@type GantryController
	local gantry_controller = {
		prototype = gantry_prototype.name,
		rotation = get_rotation[gantry_entity.direction],
		entity = gantry_entity,
		bogies = bogey_entities,
		current_task = nil,
	};
	gantry_controller_recalculate_work_area(gantry_controller);
	return gantry_controller;
end

---Redetermins the work area as a rectangle representing the area the gantry has access to.
---@param gantry_controller GantryController self.
function gantry_controller_recalculate_work_area(gantry_controller)
	---@type GantryPrototype
	local prototype = intermodal_logistics_game:get_prototype_by_name(gantry_controller.prototype);
	---@type GantryPrototypeRotation
	local rotation = prototype.rotations[gantry_controller.rotation];

	local gantry_position = gantry_controller.entity.position;

	local left_top = {
		x = gantry_position.x,
		y = gantry_position.y,
	};
	local right_bottom = {
		x = gantry_position.x,
		y = gantry_position.y,
	};

	-- rotation.work_width.left
	-- rotation.work_width.right
	local length = 12; --Length of the track

	---@type {[string]: fun()} Transforms the positions according to the rotation.
	local switch = {
		north = function ()
			-- TODO:
		end,
		-- The 'default' rotation of the gantry. This is to say,
		-- This is the only rotation where the names of the variables make any sense.
		east = function ()
			-- Width
			left_top.x = left_top.x - rotation.work_width.left;
			right_bottom.x = right_bottom.x + rotation.work_width.right;
			-- Height
			-- TODO:
		end,
		south = function ()
			-- TODO:
		end,
		west = function ()
			-- TODO:
		end,
	};

	gantry_controller.work_area = {
		left_top = left_top,
		right_bottom = right_bottom,
	};
end


---Function to test if a gantry is capable of completing a given task.
---
---@param gantry_controller GantryController
---@param task GantryTask
---@return boolean # True if both sockets are within the gantry's work area.
function gantry_controller_can_complete_task(gantry_controller, task)
	local work_area = gantry_controller_get_work_area(gantry_controller);
	local start_s_position = task.starting_socket.entity.position;
	local end_s_position = task.ending_socket.entity.position;

	-- Is starting socket outside work area?
	if(not bounding_box_is_position_inside(work_area, start_s_position)) then
		return false;
	end
	-- Is ending socket outside work area?
	if(not bounding_box_is_position_inside(work_area, end_s_position)) then
		return false;
	end

	return true;
end

---Orders a gantry to perform a specific task.
---@param gantry_controller GantryController
---@param task GantryTask
function gantry_give_task(gantry_controller, task)
	--TODO:
end

---Destroys all the bogies accociated with a gantry.
---@param gantry_controller GantryController
function gantry_controller_destroy(gantry_controller)
	local bogies = gantry_controller.bogies;
	for i = 1, #bogies, 1 do
		bogies[i].destroy();
	end
end

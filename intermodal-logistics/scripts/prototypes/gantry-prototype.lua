---@class GantryPrototype: CustomPrototype
---@field placement_dummy_prototype string The name of the prototype used when placing a gantry on a surface.
---@field rotations {north: GantryPrototypeRotation, east: GantryPrototypeRotation, south: GantryPrototypeRotation, west: GantryPrototypeRotation} The specific data for each rotation of the placed gantry.

---@class UncenteredWidth
---@field left number The distance to the left.
---@field right number The distance to the right.

---@class GantryPrototypeRotation
---@field prototype string The name of the prototype to be used for this rotation.
---@field work_width UncenteredWidth The width in tiles that the gantry trolley can cover. X is negative direction and Y is positive direction.
---@field bogies GantryPrototypeBogey[] The bogey on this rotation.

---@class GantryPrototypeBogey
---@field prototype string The name of this bogey's prototype.
---@field positions MapPosition[] An array of all the positions this bogey should appear in.

---Constructor for a new gantry prototype.
---@param placement_dummy_prototype string The name of the entity prototype to use for player placement.
---@param work_width UncenteredWidth The name of the entity prototype to use for player placement.
---@param clone_north boolean? Whether the north and south rotations should share a table. Default: false.
---@param clone_east boolean? Whether the east and west rotations should share a table. Default: false.
---@return GantryPrototype # The new gantry prototype table.
function make_gantry_prototype(placement_dummy_prototype, work_width, clone_north, clone_east)
	clone_north = clone_north or false;
	clone_east = clone_east or false;
	local north = { bogies = {} };
	local east = { bogies = {} };
	return {
		placement_dummy_prototype = placement_dummy_prototype,
		work_width = work_width,
		rotations = {
			north = north,
			east = east,
			south = clone_north and north or { bogies = {} },
			west = clone_east and east or { bogies = {} },
		},
	};
end

local get_rotation_key = {
	[defines.direction.north] = "north",
	[defines.direction.east] = "east",
	[defines.direction.south] = "south",
	[defines.direction.west] = "west",
};

---Calculates the number of rail tiles required to place this gantry.
---@param gantry_prototype GantryPrototype self.
---@param direction defines.direction The defines.direction rotation of the gantry to sample.
---@return number # The number of rails required to place this gantry.
function gantry_prototype_get_required_number_of_rails(gantry_prototype, direction)
	local total_number_of_rails = 0;

	local rotation_key = get_rotation_key[direction];
	if (rotation_key) then
		---@type GantryPrototypeRotation
		local rotation = gantry_prototype.rotations[rotation_key];
		local bogies = rotation.bogies;
		for _, bogie in ipairs(bogies) do
			local bogie_prototype = game.entity_prototypes[bogie.prototype];
			local bogie_count = #(bogie.positions);
			total_number_of_rails = total_number_of_rails + (bogie_count * bogie_prototype.tile_width)
		end
	else
		error("Invalid direction, can only be: north, east, south, west.")
	end

	return total_number_of_rails;
end

---Checks an entity against the gantry prototype to see if it can be placed in its current location.
---@param gantry_prototype GantryPrototype The gantry protoype to use for the check.
---@param gantry_dummy_entity LuaEntity The dummy entity to check.
---@return boolean # True if the gantry is not obstructed.
function gantry_prototype_check_for_obstructions(gantry_prototype, gantry_dummy_entity)
	---@type GantryPrototypeRotation
	local rotation = gantry_prototype.rotations[get_rotation_key[gantry_dummy_entity.direction]];

	-- Check each bogey on the gantry.
	for _, bogey in ipairs(rotation.bogies) do
		local bogey_prototype = game.entity_prototypes[bogey.prototype];
		for _, position in ipairs(bogey.positions) do
			local count = gantry_dummy_entity.surface.count_entities_filtered {
				area = bogey_prototype.collision_box,
				collision_mask = bogey_prototype.collision_mask };
			if (count > 0) then
				return false;
			end
		end
	end
	return true;
end

---Checks an entity against the gantry prototype to see if there are rails placed under the bogies.
---@param gantry_prototype GantryPrototype The gantry protoype to use for the check.
---@param gantry_dummy_entity LuaEntity The dummy entity to check.
---@return boolean # True if the gantry has rails under its bogies.
function gantry_prototype_check_for_rails(gantry_prototype, gantry_dummy_entity)
	---@type GantryPrototypeRotation
	local rotation = gantry_prototype.rotations[get_rotation_key[gantry_dummy_entity.direction]];

	local required_number_of_rails = gantry_prototype_get_required_number_of_rails(gantry_prototype, gantry_dummy_entity.direction);
	local number_of_rails = 0;

	--TODO: This may need to be changed depending on how I implement rails later.
	local hunt_direction = gantry_dummy_entity.direction;
	if(hunt_direction == defines.direction.west) then hunt_direction = defines.direction.east; end
	if(hunt_direction == defines.direction.south) then hunt_direction = defines.direction.north; end

	-- Check each bogey on the gantry.
	for _, bogey in ipairs(rotation.bogies) do
		local bogey_prototype = game.entity_prototypes[bogey.prototype];
		for _, position in ipairs(bogey.positions) do
			local count = gantry_dummy_entity.surface.count_entities_filtered {
				area = bogey_prototype.collision_box,
				name = intermodal_logistics_game:get_rail_prototypes(),
				direction = hunt_direction,
			};
			number_of_rails = number_of_rails + count;
		end
	end
	return required_number_of_rails == number_of_rails;
end

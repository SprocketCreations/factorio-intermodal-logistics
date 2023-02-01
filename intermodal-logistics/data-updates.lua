require("util.stringify");

---@class GantryData
---@field placement_dummy_prototype string The name of the prototype used when placing a gantry on a surface.
---@field rotations GantryRotationsData The specific data for each rotation of the placed gantry.

---@class GantryRotationsData
---@field north GantryRotationData
---@field east GantryRotationData
---@field south GantryRotationData
---@field west GantryRotationData

---@class GantryRotationData
---@field prototype string The name of the prototype to be used for this rotation.
---@field work_width number | number The width in tiles that the gantry trolley can cover.
---@field trucks TruckData[] The trucks on this rotation.

---@class TruckData
---@field prototype string The name of this truck's prototype.
---@field positions (double | double)[] An array of all the positions this truck should appear in.


---@class CradleData

---@class FlatbedData

---@type table[] Array of gantry prototypes.
local gantries = intermodal_logistics.raw.gantry;
---@type table[] Array of cradle prototypes.
local cradles = intermodal_logistics.raw.cradle;
---@type table[] Array of flatbed prototypes.
local flatbeds = intermodal_logistics.raw.flatbed;
local pipeline = {
	---@type {[string]: table} Map of all the generated control data for gantries.
	gantries = {};
	---@type {[string]: table} Map of all the generated control data for cradles.
	cradles = {};
	---@type {[string]: table} Map of all the generated control data for flatbeds.
	flatbeds = {};
};

---Saves a gantry's control data to be transported to the game runtime.
---@param name string
---@param data GantryData
pipeline.save_gantry = function(self, name, data)
	self.gantries[name] = data;
end

---Saves a gantry's control data to be transported to the game runtime.
---@param name string
---@param data CradleData
pipeline.save_cradle = function(self, name, data)
	self.cradles[name] = data;
end

---Saves a gantry's control data to be transported to the game runtime.
---@param name string
---@param data FlatbedData
pipeline.save_flatbed = function(self, name, data)
	self.flatbeds[name] = data;
end

---Creates a 'simple-entity' to represent a truck.
---@param truck_data table
---@return string prototype the name of the prototype created.
local create_truck = function(truck_data)
	local truck = {
		name = truck_data.name;
		-- inherited from parent gantry
		max_health = truck_data.max_health;
		resistances = truck_data.resistances;
		icon = truck_data.icon;
		icons = truck_data.icons;
		icon_size = truck_data.icon_size;
		icon_mipmaps = truck_data.icon_mipmaps;
		-- truck specific
		animations = truck_data.animations;
		picture = truck_data.picture;
		pictures = truck_data.pictures;
		random_animation_offset = truck_data.random_animation_offset;
		random_variation_on_create = truck_data.random_variation_on_create;
		render_layer = truck_data.render_layer or "object";
		secondary_draw_order = truck_data.secondary_draw_order;
		alert_when_damaged = false;
		create_ghost_on_death = false;
		integration_patch = truck_data.integration_patch;
		integration_patch_render_layer = truck_data.integration_patch_render_layer;
		allow_copy_paste = false;
		collision_box = truck_data.collision_box;
		drawing_box = truck_data.drawing_box;
		enemy_map_color = { 0, 0, 0, 0 };
		flags = {
			"not-rotatable",
			"not-on-map",
			"not-blueprintable",
			"not-deconstructable",
			"hidden",
			"no-automated-item-removal",
			"no-automated-item-insertion",
			"no-copy-paste",
			"not-upgradeable",
			"not-in-kill-statistics"
		};
		friendly_map_color = { 0, 0, 0, 0 };
		hit_visualization_box = truck_data.hit_visualization_box;
		map_color = { 0, 0, 0, 0 };
		subgroup = truck_data.subgroup or "gantry-trucks";
		tile_height = truck_data.tile_height;
		tile_width = truck_data.tile_width;
		vehicle_impact_sound = truck_data.vehicle_impact_sound;
		water_reflection = truck_data.water_reflection;
		working_sound = truck_data.working_sound;
		type = "simple-entity";
		order = truck_data.order;
	};
	data:extend { truck };
	return truck.name;
end
-- gantry_data.flags must contain "not-rotatable"
local create_gantry = function(gantry_data)
	local directions = { "north", "east", "south", "west" };
	local names = { gantry_data.name .. "_north", gantry_data.name .. "_east", gantry_data.name .. "_west",
		gantry_data.name .. "_south" };
	for i = 1, 4, 1 do
		local direction = directions[i];
		local gantry_direction_data = gantry_data.rotations[direction];
		if (gantry_direction_data ~= nil) then
			local gantry = {
				-- Stuff that's the same for all the gantry rotations:
				render_layer = gantry_data.render_layer or "higher-object-above";
				secondary_draw_order = gantry_data.secondary_draw_order;
				allow_run_time_change_of_is_military_target = gantry_data.allow_run_time_change_of_is_military_target or false;
				is_military_target = gantry_data.is_military_target or false;
				alert_when_damaged = gantry_data.alert_when_damaged or true;
				attack_reaction = gantry_data.attack_reaction;
				corpse = gantry_data.corpse;
				create_ghost_on_death = gantry_data.create_ghost_on_death or true;
				damage_trigger_effect = gantry_data.damage_trigger_effect;
				dying_explosion = gantry_data.dying_explosion;
				dying_trigger_effect = gantry_data.dying_trigger_effect;
				hide_resistances = gantry_data.hide_resistances or false;
				integration_patch_render_layer = gantry_data.integration_patch_render_layer or "lower-object";
				max_health = gantry_data.max_health or 2500;
				random_corpse_variation = gantry_data.random_corpse_variation or false;
				repair_sound = gantry_data.repair_sound;
				repair_speed_modifier = gantry_data.repair_speed_modifier or 0.25;
				resistances = gantry_data.resistances or { {
					type = "physical";
					decrease = 10;
					percent = 20;
				}, {
					type = "fire";
					percent = 100;
				} };
				icon = gantry_data.icon;
				icons = gantry_data.icons;
				icon_size = gantry_data.icon_size;
				icon_mipmaps = gantry_data.icon_mipmaps;
				alert_icon_scale = gantry_data.alert_icon_scale;
				alert_icon_shift = gantry_data.alert_icon_shift;
				allow_copy_paste = gantry_data.allow_copy_paste;
				enemy_map_color = gantry_data.enemy_map_color;
				fast_replaceable_group = gantry_data.fast_replaceable_group;
				flags = gantry_data.flags;
				friendly_map_color = gantry_data.friendly_map_color;
				map_color = gantry_data.map_color;
				minable = gantry_data.minable;
				mined_sound = gantry_data.mined_sound;
				next_upgrade = gantry_data.next_upgrade;
				placeable_by = gantry_data.placeable_by;
				protected_from_tile_building = gantry_data.protected_from_tile_building;
				selectable_in_game = true;
				selection_priority = gantry_data.selection_priority;
				subgroup = gantry_data.subgroup or "gantry";
				tile_width = gantry_data.tile_width;
				tile_height = gantry_data.tile_height;
				vehicle_impact_sound = gantry_data.vehicle_impact_sound;
				water_reflection = gantry_data.water_reflection;
				working_sound = gantry_data.working_sound;
				type = "simple-entity-with-owner";
				order = gantry_data.order;
				-- Stuff that's different for each rotation:
				animations = gantry_direction_data.animations;
				integration_patch = gantry_direction_data.integration_patch;
				picture = gantry_direction_data.picture;
				pictures = gantry_direction_data.pictures;
				random_animation_offset = gantry_direction_data.random_animation_offset or true;
				random_variation_on_create = gantry_direction_data.random_variation_on_create or true;
				drawing_box = gantry_direction_data.drawing_box;
				hit_visualization_box = gantry_direction_data.hit_visualization_box;
				shooting_cursor_size = gantry_direction_data.shooting_cursor_size;
				selection_box = gantry_direction_data.selection_box;
				name = names[i];
			};
			data:extend { gantry };
		end
	end
	return names[1], names[2], names[3], names[4];
end

---Creates and extends a 'simple-entity-with-owner' to be placed by the player.
---@param gantry_data table
---@return string prototype the name of the dummy prototype.
local create_gantry_placement_dummy = function(gantry_data)
	local gantry = {
		icon = gantry_data.icon;
		icons = gantry_data.icons;
		icon_size = gantry_data.icon_size;
		icon_mipmaps = gantry_data.icon_mipmaps;
		picture = gantry_data.pictures;
		pictures = gantry_data.pictures;
		render_layer = gantry_data.render_layer or "higher-object-above";
		secondary_draw_order = gantry_data.secondary_draw_order;
		build_sound = gantry_data.build_sound;
		created_effect = gantry_data.created_effect;
		subgroup = gantry_data.subgroup or "gantry";
		tile_width = gantry_data.tile_width;
		tile_height = gantry_data.tile_height;
		name = gantry_data.name;
		type = "simple-entity-with-owner";
		order = gantry_data.order;
	}
	data:extend { gantry };
	return gantry.name;
end

---Takes the dev given table of gantry configuration and mutates it to be more useable.
---@param gantry table
---@return table
local verify_gantry_data = function(gantry)
	local rotations = gantry.rotations;

	-- collect all the truck entries
	local ground_trucks = {
		table.unpack(rotations.north.ground_trucks),
		table.unpack(rotations.east.ground_trucks),
		table.unpack(rotations.south.ground_trucks or {}),
		table.unpack(rotations.west.ground_trucks or {}),
	};
	-- Get all the truck prototypes
	---@type {[table]: true} A Set of trucks
	local trucks_set = {};
	for i = 1, #ground_trucks, 1 do
		trucks_set[ground_trucks[i].truck] = true;
	end

	-- Convert from keys to values
	local trucks = {};
	for truck, _ in pairs(trucks_set) do
		table.insert(trucks, truck);
	end

	local data = {
		clone_north_to_south = rotations.south.ground_trucks == nil;
		clone_east_to_west = rotations.west.ground_trucks == nil;
		gantry_data = gantry;
		trucks = trucks;
	};
	return data;
end

if (gantries ~= nil) then
	for _, gantry in pairs(gantries) do
		-- do gantry stuff
		local data = verify_gantry_data(gantry);

		local gantry_data = data.gantry_data;
		local trucks = data.trucks;

		local placement_dummy_name = create_gantry_placement_dummy(gantry_data);
		local gantry_north_name, gantry_east_name, gantry_south_name, gantry_west_name = create_gantry(gantry_data);

		for i = 1, #trucks, 1 do
			trucks[i].prototype = create_truck(trucks[i]);
		end

		local gantry_control = {
			placement_dummy_prototype = placement_dummy_name;
			rotations = {};
		};

		do -- North
			local north = gantry_data.rotations.north;
			gantry_control.rotations.north = {
				prototype = gantry_north_name;
				work_width = north.work_width;
				trucks = {};
			};
			local north_trucks = north.ground_trucks;
			for i = 1, #north_trucks, 1 do
				table.insert(trucks, {
					prototype = north_trucks[i].prototype;
					positions = north_trucks[i].positions;
				});
			end
		end
		do -- East
			local east = gantry_data.rotations.east;
			gantry_control.rotations.east = {
				prototype = gantry_east_name;
				work_width = east.work_width;
				trucks = {};
			};
			local east_trucks = east.ground_trucks;
			for i = 1, #east_trucks, 1 do
				table.insert(trucks, {
					prototype = east_trucks[i].prototype;
					positions = east_trucks[i].positions;
				});
			end
		end
		if(data.clone_north_to_south) then -- South
			gantry_control.rotations.south = gantry_control.rotations.north;
		else
			local south = gantry_data.rotations.south;
			gantry_control.rotations.south = {
				prototype = gantry_south_name;
				work_width = south.work_width;
				trucks = {};
			};
			local south_trucks = south.ground_trucks;
			for i = 1, #south_trucks, 1 do
				table.insert(trucks, {
					prototype = south_trucks[i].prototype;
					positions = south_trucks[i].positions;
				});
			end
		end
		if(data.clone_east_to_west) then -- West
			gantry_control.rotations.west = gantry_control.rotations.east;
		else
			local west = gantry_data.rotations.west;
			gantry_control.rotations.west = {
				prototype = gantry_west_name;
				work_width = west.work_width;
				trucks = {};
			};
			local west_trucks = west.ground_trucks;
			for i = 1, #west_trucks, 1 do
				table.insert(trucks, {
					prototype = west_trucks[i].prototype;
					positions = west_trucks[i].positions;
				});
			end
		end
		pipeline:save_gantry(placement_dummy_name, gantry_control);
	end
end

if (cradles ~= nil) then
	for _, cradle in pairs(cradles) do
		-- do cradle stuff
	end
end

if (flatbeds ~= nil) then
	for _, flatbed in pairs(flatbeds) do
		-- do flatbe stuff
	end
end

local not_json = stringify_table(pipeline);
data:extend{
	order = not_json;
	name = "gantry-data-control-pipeline";
	type = "item-subgroup";
	group = "gantry-group";
};

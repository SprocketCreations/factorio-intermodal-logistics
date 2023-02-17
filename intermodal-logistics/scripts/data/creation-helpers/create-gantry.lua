-- gantry_data.flags must contain "not-rotatable"
---@param gantry_data any
---@return string
---@return string
---@return string
---@return string
function create_gantry(gantry_data)
	local directions = { "north", "east", "south", "west" };
	local names = { gantry_data.name .. "-north", gantry_data.name .. "-east", gantry_data.name .. "-south", gantry_data.name .. "-west" };
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
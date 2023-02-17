
---Creates a 'simple-entity' to represent a bogey.
---@param bogey_data table
---@return string prototype the name of the prototype created.
function create_bogey(bogey_data)
	local bogey = {
		name = bogey_data.name;
		-- inherited from parent gantry
		max_health = bogey_data.max_health;
		resistances = bogey_data.resistances;
		icon = bogey_data.icon;
		icons = bogey_data.icons;
		icon_size = bogey_data.icon_size;
		icon_mipmaps = bogey_data.icon_mipmaps;
		-- bogey specific
		animations = bogey_data.animations;
		picture = bogey_data.picture;
		pictures = bogey_data.pictures;
		random_animation_offset = bogey_data.random_animation_offset;
		random_variation_on_create = bogey_data.random_variation_on_create;
		render_layer = bogey_data.render_layer or "object";
		secondary_draw_order = bogey_data.secondary_draw_order;
		alert_when_damaged = false;
		create_ghost_on_death = false;
		integration_patch = bogey_data.integration_patch;
		integration_patch_render_layer = bogey_data.integration_patch_render_layer;
		allow_copy_paste = false;
		collision_box = bogey_data.collision_box;
		drawing_box = bogey_data.drawing_box;
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
			"not-upgradable",
			"not-in-kill-statistics"
		};
		friendly_map_color = { 0, 0, 0, 0 };
		hit_visualization_box = bogey_data.hit_visualization_box;
		map_color = { 0, 0, 0, 0 };
		subgroup = bogey_data.subgroup or "gantry-bogey";
		tile_height = bogey_data.tile_height;
		tile_width = bogey_data.tile_width;
		vehicle_impact_sound = bogey_data.vehicle_impact_sound;
		water_reflection = bogey_data.water_reflection;
		working_sound = bogey_data.working_sound;
		type = "simple-entity-with-owner";
		order = bogey_data.order;
	};
	data:extend { bogey };
	return bogey.name;
end
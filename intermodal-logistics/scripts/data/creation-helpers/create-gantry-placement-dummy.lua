---Creates and extends a 'simple-entity-with-owner' to be placed by the player.
---@param gantry_data table
---@return string prototype the name of the dummy prototype.
function create_gantry_placement_dummy(gantry_data)
	local gantry = {
		icon = gantry_data.icon;
		icons = gantry_data.icons;
		icon_size = gantry_data.icon_size;
		icon_mipmaps = gantry_data.icon_mipmaps;
		picture = {
			north = gantry_data.rotations.north.pictures;
			east = gantry_data.rotations.east.pictures;
			south = gantry_data.rotations.south.pictures;
			west = gantry_data.rotations.west.pictures;
		};
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
	};
	data:extend { gantry };
	return gantry.name;
end
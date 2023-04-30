local vertical_picture = {
	filename = "__intermodal-logistics__/graphics/entity/gantry-rail/vertical.png",
	priority = "low",
	size = { 128, 128 },
	scale = 0.25,
};
local horizontal_picture = {
	filename = "__intermodal-logistics__/graphics/entity/gantry-rail/horizontal.png",
	priority = "low",
	size = { 128, 128 },
	scale = 0.25,
};

intermodal_logistics_data:extend {
	{
		-- Entity
		icon = "__intermodal-logistics__/graphics/entity/rail/horizontal.png",
		icon_size = 128,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		collision_mask = { "item-layer", "object-layer", "water-tile" },
		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
		tile_width = 1,
		tile_height = 1,
		-- placeable_by = {
		-- 	item = "gantry-rail";
		-- 	count = 1;
		-- };
		-- minable = {
		-- 	mining_time = 0.2;
		-- 	result = "gantry-rail";
		-- };

		render_layer = "floor",
		secondary_draw_order = 25,
		picture = {
			north = vertical_picture,
			east = horizontal_picture,
			south = vertical_picture,
			west = horizontal_picture,
		},
		selection_priority = 20,
		flags = {
			"placeable-neutral",
			"player-creation",
			"not-flammable",
		},
		-- Base
		name = "intermodal-logistics-gantry-rail",
		type = "gantry-rail",
		order = "aa",
	},
};

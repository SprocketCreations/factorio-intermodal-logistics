data:extend {
	{
		-- Entity
		icon = "todo";

		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } };
		collision_mask = { "item-layer", "object-layer", "water-tile" };

		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } };

		tile_width = 1;
		tile_height = 1;

		placeable_by = {
			item = "gantry-rail";
			count = 1;
		};
		minable = {
			mining_time = 0.2;
			result = "gantry-rail";
		};

		pictures = {
			variation_count = 4;
			repeat_count = 1; --<== What is this
			line_length = 4;

			filename = "__intermodal-containers-and-gantry__/graphics/entity/rail/rail.png"
		};

		selection_priority = 20;
		flags = {
			"placeable-neutral";
			"player-creation";
			"not-flammable";
		};
		-- Base
		name = "gantry-rail";
		type = "simple-entity-with-owner";
		order = "aa";
	},
};

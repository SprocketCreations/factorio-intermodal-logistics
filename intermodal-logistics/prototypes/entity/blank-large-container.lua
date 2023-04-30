intermodal_logistics_data:extend {
	{
		type = "large-container",
		name = "intermodal-logistics-blank-large-container",
		-- https://wiki.factorio.com/Types/RotatedSprite
		pictures = {
			direction_count = 128,
			filenames = {
				"__intermodal-logistics__/graphics/entity/blank-large-container/blank-large-container-0.png",
				"__intermodal-logistics__/graphics/entity/blank-large-container/blank-large-container-1.png",
				"__intermodal-logistics__/graphics/entity/blank-large-container/blank-large-container-2.png",
				"__intermodal-logistics__/graphics/entity/blank-large-container/blank-large-container-3.png",
			},
			priority = "very-low",
			size = { 256, 256 },
			position = { 0, 0 },
			shift = { -0.0, -0.5427521467208862 },
			scale = 1,
			apply_runtime_tint = true,
			back_equals_front = true,
			line_length = 4,
			allow_low_quality_rotation = true,
			lines_per_file = 8,
		},
		-- The bottom of the container. Used to calculate vertical allignment with wagons and gantries.
		vertical_offset = 0,
		-- Number of items that can be put in this container
		inventory_size = 40,
	}
};

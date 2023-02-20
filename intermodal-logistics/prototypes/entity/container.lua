intermodal_logistics_data:extend {
	{
		type = "container",
		name = "default-container",
		-- https://wiki.factorio.com/Types/RotatedSprite
		pictures = {
			direction_count = 128,
			filenames = {
				"__intermodal-logistics__/graphics/entity/container/default-container/default-container-0.png",
				"__intermodal-logistics__/graphics/entity/container/default-container/default-container-1.png",
				"__intermodal-logistics__/graphics/entity/container/default-container/default-container-2.png",
				"__intermodal-logistics__/graphics/entity/container/default-container/default-container-3.png",
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
		-- The bottom of the container. Essentially, if 0; the container would be resting on the ground.
		vertical_offset = 0,
		-- How many 'slots' this container needs.
		length = 2,
		-- Number of items that can be put in this container
		inventory_size = 40,
	}
};

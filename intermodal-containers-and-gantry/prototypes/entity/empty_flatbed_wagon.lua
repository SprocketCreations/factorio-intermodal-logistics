-- Copy the vanilla cargo wagon
local empty_flatbed_wagon = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"]);
-- Override everything I need to
empty_flatbed_wagon.name = "flatbed_wagon";
empty_flatbed_wagon.icon = "__intermodal-containers-and-gantry__/graphics/item/empty-flatbed-wagon.png";
empty_flatbed_wagon.icon_size = 32;
empty_flatbed_wagon.icon_mipmaps = 1;
empty_flatbed_wagon.inventory_size = 0;
empty_flatbed_wagon.minable = { mining_time = 1, result = "flatbed_wagon" }
-- This is a flatbed and has no doors
empty_flatbed_wagon.horizontal_doors = nil;
empty_flatbed_wagon.vertical_doors = nil;

--[[
	The vanilla cargo wagon is 1000 weight

	According to this product: https://www.vtg.com/hiring/our-fleet/i41040d,
	the ratio between rolling stock and container is 1/3.

	Therefore, the weight of this rolling stock should be 1/4 of the vanilla 
	cargo wagon.
--[[]]
empty_flatbed_wagon.weight = 250;

empty_flatbed_wagon.minimap_representation =
{
	filename = "__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5,
}
empty_flatbed_wagon.selected_minimap_representation =
{
	filename = "__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5,
}


-- RotatedSprite pictures
empty_flatbed_wagon.pictures =
{
	layers =
	{
		-- VISABLE LAYER
		{
			priority = "very-low",
			width = 238,
			height = 230,
			direction_count = 256,
			allow_low_priority_rotation = true;
			lines_length = 4;
			lines_per_file = 8;
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-04.png",
			},

			hr_version =
			{
				priority = "very-low",
				width = 474,
				height = 458,
				direction_count = 256,
				allow_low_priority_rotation = true;
				lines_length = 4;
				lines_per_file = 4;
				scale = 0.5;
				filenames =
				{
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-01.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-02.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-03.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-04.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-05.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-06.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-07.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-08.png",
				},
			},
		},
		-- Color mask
		{
			flags = { "mask" };
			priority = "very-low",
			width = 236,
			height = 226,
			direction_count = 256,
			allow_low_priority_rotation = true;
			lines_length = 4;
			lines_per_file = 8;
			apply_runtime_tint = true;
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-04.png",
			},

			hr_version =
			{
				flags = { "mask" };
				priority = "very-low",
				width = 472,
				height = 456,
				direction_count = 256,
				allow_low_priority_rotation = true;
				lines_length = 4;
				lines_per_file = 4;
				scale = 0.5;
				apply_runtime_tint = true;
				filenames =
				{
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-01.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-02.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-03.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-04.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-05.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-06.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-07.png",
					"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-08.png",
				},
			},
		},
		-- Shadow
		{
			flags = { "shadow" };
			priority = "very-low",
			width = 238,
			height = 230,
			direction_count = 256,
			draw_as_shadow = true;
			allow_low_priority_rotation = true;
			lines_length = 4;
			lines_per_file = 8;
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-04.png",
			},
		},
	},
};



data:extend(empty_flatbed_wagon);


-- Copy the vanilla cargo wagon
local intermodal_flatbed_wagon = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"]);
-- Override everything I need to
intermodal_flatbed_wagon.name = "intermodal_flatbed_wagon";
-- intermodal_flatbed_wagon.icon = "__intermodal-containers-and-gantry__/graphics/icon/empty-flatbed-wagon.png";
intermodal_flatbed_wagon.icon_size = 32;
intermodal_flatbed_wagon.icon_mipmaps = 1;
intermodal_flatbed_wagon.inventory_size = 40;
intermodal_flatbed_wagon.minable =
{
	mining_time = 1,
	results =
	{
		{
			type = "item",
			-- name = "flatbed-wagon",
			name = "iron-plate",
			amount = 1,
		},
		{
			type = "item",
			-- name = "intermodal-container",
			name = "iron-plate",
			amount = 1,
		}
	}
}
-- I may want to add clamps to this thing that release the container
intermodal_flatbed_wagon.horizontal_doors = nil;
intermodal_flatbed_wagon.vertical_doors = nil;
--[[ 
intermodal_flatbed_wagon.minimap_representation = 
{
	filename = "__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-minimap-representation.png",
	flags = { "icon" },
	size = {20, 40},
	scale = 0.5,
}
intermodal_flatbed_wagon.selected_minimap_representation = 
{
	filename = "__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-selected-minimap-representation.png",
	flags = { "icon" },
	size = {20, 40},
	scale = 0.5,
} ]]


-- RotatedSprite pictures
intermodal_flatbed_wagon.pictures =
{
	layers =
	{
		-- VISABLE LAYER
		{
			priority = "very-low",
			width = 256,
			height = 256,
			direction_count = 128,
			allow_low_priority_rotation = true;
			back_equals_front = true;
			line_length = 4;
			lines_per_file = 8;
			scale = 0.873,
			shift = {0, -0.5},
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-04.png",
			},

			--[[ hr_version =
			{
				priority = "very-low",
				width = 474,
				height = 458,
				direction_count = 256,
				allow_low_priority_rotation = true;
				back_equals_front = true;
				line_length = 4;
				lines_per_file = 4;
				scale = 0.5;
				filenames = {
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-01.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-02.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-03.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-04.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-05.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-06.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-07.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-08.png",
				},
			}, ]]
		},
		-- Color mask
		--[[ {
			flags = { "mask" };
			priority = "very-low",
			width = 236,
			height = 226,
			direction_count = 256,
			allow_low_priority_rotation = true;
			line_length = 4;
			lines_per_file = 8;
			apply_runtime_tint = true;
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-mask-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-mask-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-mask-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-mask-04.png",
			},

			hr_version =
			{
				flags = { "mask" };
				priority = "very-low",
				width = 472,
				height = 456,
				direction_count = 256,
				allow_low_priority_rotation = true;
				line_length = 4;
				lines_per_file = 4;
				scale = 0.5;
				apply_runtime_tint = true;
				filenames =
				{
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-01.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-02.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-03.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-04.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-05.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-06.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-07.png",
					"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/hr-intermodal-flatbed-wagon-mask-08.png",
				},
			},
		}, ]]
		-- Shadow
		--[[ {
			flags = { "shadow" };
			priority = "very-low",
			width = 238,
			height = 230,
			direction_count = 256,
			draw_as_shadow = true;
			allow_low_priority_rotation = true;
			line_length = 4;
			lines_per_file = 8;
			filenames =
			{
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-shadow-01.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-shadow-02.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-shadow-03.png",
				"__intermodal-containers-and-gantry__/graphics/entity/intermodal-flatbed-wagon/intermodal-flatbed-wagon-shadow-04.png",
			},
		}, ]]
	},
};


data:extend({intermodal_flatbed_wagon});
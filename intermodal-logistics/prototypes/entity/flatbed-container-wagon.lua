-- Copy the vanilla cargo wagon
local flatbed_container_wagon = util.table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"]);
-- Intermodal logistics stuff:
flatbed_container_wagon.type = "container-wagon";
flatbed_container_wagon.container_length = 2;
flatbed_container_wagon.max_container_stack = 1;
flatbed_container_wagon.allow_half_loading = true;
-- Vanilla stuff:
flatbed_container_wagon.name = "flatbed-wagon";
-- empty_flatbed_wagon.icon = "__intermodal-logistics__/graphics/icon/empty-flatbed-wagon.png";
-- empty_flatbed_wagon.icon_size = 32;
-- empty_flatbed_wagon.icon_mipmaps = 1;
flatbed_container_wagon.inventory_size = 1;
flatbed_container_wagon.mineable =
{
	mining_time = 1,
	result = "iron-plate"
	--result = "flatbed-wagon"
}
-- This is a flatbed and has no doors
flatbed_container_wagon.horizontal_doors = nil;
flatbed_container_wagon.vertical_doors = nil;

--[[
	The vanilla cargo wagon is 1000 weight

	According to this product: https://www.vtg.com/hiring/our-fleet/i41040d,
	the ratio between rolling stock and container is 1:3.

	Therefore, the weight of this rolling stock should be 1/4 of the vanilla 
	cargo wagon.
--[[]]
flatbed_container_wagon.weight = 250;
--[[ 
empty_flatbed_wagon.minimap_representation =
{
	filename = "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5,
}
empty_flatbed_wagon.selected_minimap_representation =
{
	filename = "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-selected-minimap-representation.png",
	flags = { "icon" },
	size = { 20, 40 },
	scale = 0.5,
} ]]

flatbed_container_wagon.joint_distance = 8;-- default 4
flatbed_container_wagon.collision_box = {{-0.6, -4.4}, {0.6, 4.4}};-- default {{-0.6, -2.4}, {0.6, 2.4}}
flatbed_container_wagon.selection_box = {{-1, -4.703125}, {1, 5.296875}};-- default {{-1, -2.703125}, {1, 3.296875}}


-- RotatedSprite pictures
flatbed_container_wagon.pictures =
{
	layers =
	{
		-- VISABLE LAYER
		{
			priority = "very-low",
			width = 256,
			height = 256,
			direction_count = 128,
			allow_low_quality_rotation = true,
			back_equals_front = true,
			line_length = 4,
			lines_per_file = 8,
			scale = 0.873,
			shift = {0, -0.5},
			filenames =
			{
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-01.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-02.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-03.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-04.png",
			},
			-- hr_version =
			-- {
			-- 	priority = "very-low",
			-- 	dice = 4,
			-- 	width = 442,
			-- 	height = 407,
			-- 	back_equals_front = true,
			-- 	direction_count = 128,
			-- 	allow_low_priority_rotation = true,
			-- 	filenames =
			-- 	{
			-- 		-- "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-01.png",
			-- 		-- "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-02.png",
			-- 		-- "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-03.png",
			-- 		-- "__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-04.png",
			-- 	},
			-- 	line_length = 4,
			-- 	lines_per_file = 4,
			-- 	scale = 0.5;
			-- },
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
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-01.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-02.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-03.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-mask-04.png",
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
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-01.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-02.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-03.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-04.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-05.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-06.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-07.png",
					"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/hr-empty-flatbed-wagon-mask-08.png",
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
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-01.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-02.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-03.png",
				"__intermodal-logistics__/graphics/entity/empty-flatbed-wagon/empty-flatbed-wagon-shadow-04.png",
			},
		}, ]]
	},
};



intermodal_logistics_data:extend({flatbed_container_wagon});

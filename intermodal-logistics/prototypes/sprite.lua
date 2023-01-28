
local up_arrow = {
	type = "sprite",
	name = "up_arrow_sprite",
	filename = "__intermodal-logistics__/graphics/mip/up-arrow.png",
	priority = "extra-high-no-scale",
	flags = {"gui-icon"},
	size = {32, 32},
	mipmap_count = 2,
};

local up_arrow_dark = {
	type = "sprite",
	name = "up_arrow_dark_sprite",
	filename = "__intermodal-logistics__/graphics/mip/up-arrow-dark.png",
	priority = "extra-high-no-scale",
	flags = {"gui-icon"},
	size = {32, 32},
	mipmap_count = 2,
};


data:extend{up_arrow, up_arrow_dark};
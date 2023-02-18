local dock = {
	-- Item
	icon = "__intermodal-logistics__/graphics/icon/intermodal-dock.png",
	icon_size = 32,
	stack_size = 50,
	place_result = "dock-dummy",
	subgroup = "dock",
	-- Base
	name = "intermodal-dock",
	type = "item",
	order = "c",
}

data:extend{dock};
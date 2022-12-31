function MakeCradle(
    name,
    order,
    flags,
    width,
	height,
    hasContainer,
    picture,
    hr_picture,
	imageWidth,
	imageHeight
)
	local selectionBox = {{width / -2, height / -2}, {width / 2, height / 2}};
	local collisionBox = {{width / -2 - 0.1, height / -2 - 0.1}, {width / 2 - 0.1, height / 2 - 0.1}};

	local cradle =
	{
		
		-- Base
		type = "container",
		name = name,
		order = order,
		-- Entity
		icon_size = 32,
		icon = "__intermodal-containers-and-gantry__/graphics/icon/intermodal-cradle.png",
		flags = flags,
		-- build_sound = { filename = "__intermodal-containers-and-gantry__/sounds/cradle-place.ogg" },
		-- open_sound =  { filename = "__intermodal-containers-and-gantry__/sounds/intermodal-open.ogg" },
		-- close_sound = { filename = "__intermodal-containers-and-gantry__/sounds/intermodal-close.ogg" },
	
		collision_box = collisionBox,
		selection_box = selectionBox,
	
		shooting_cursor_size = 50,
	
		--subgroup = "intermodal-cradle",
	
		-- yoinked from sounds.impact_generic
		vehicle_impact_sound =
		{
			{
				filename = "__base__/sound/car-metal-impact-2.ogg", volume = 0.5
			},
			{
				filename = "__base__/sound/car-metal-impact-3.ogg", volume = 0.5
			},
			{
				filename = "__base__/sound/car-metal-impact-4.ogg", volume = 0.5
			},
			{
				filename = "__base__/sound/car-metal-impact-5.ogg", volume = 0.5
			},
			{
				filename = "__base__/sound/car-metal-impact-6.ogg", volume = 0.5
			}
		},
	
		placeable_by =
		{
			item = "iron-plate",
			--item = "intermodal-cradle",
			count = 1,
		},
	
		minable =
		{
			mining_time = 1,
			results =
			{
				{
					type = "item",
					name = "iron-plate",
					--name = "intermodal-cradle",
					amount = 1,
				},
				--[[ hasContainer and
				{
					type = "item",
					name = "intermodal-container",
					amount = 1,
				} ]]
			},
		},
	
		-- Entity with Health
		alert_when_damaged = true,
		--corpse = "intermodal-container",
		create_ghost_on_death = true,
		max_health = 250,
		resistances =
		{
			{
				type = "fire",
				percent = 20,
			},
			{
				type = "impact",
				percent = 10,
			},
			{
				type = "acid",
				percent = 5,
			}
		},
	
		-- Entity with Owner
	
		-- Container
		inventory_size = hasContainer and 40 or 0,
		picture =
		{
			filename = picture,
			priority = "very-low",
			width = imageWidth,
			height = imageHeight,
			--[[ hr_version =
			{
				filename = hr_picture,
				priority = "very-low",
				width = imageWidth * 2,
				height = imageHeight * 2,
				scale = 0.5,
			}, ]]
		},
		--circuit_connector_sprites = ,
		circuit_wire_connection_point =
		{
			wire =
			{
				red = { 0, 0 },
				green = { 0, 1 },
			},
			shadow =
			{
				red = { 1, 0 },
				green = { 1, 1 },
			}
		},
		circuit_wire_max_distance = 8,
	};
	return cradle;
end

local horizontal_empty_cradle = MakeCradle(
    "horizontal-empty-cradle",
    "aa",
    { "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable" },
    6,
	2,
    false,
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/horizontal-empty-cradle.png",
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/horizontal-empty-cradle.png",
	256,
	128
);
local vertical_empty_cradle = MakeCradle(
    "vertical-empty-cradle",
    "aa",
    { "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable" },
    2,
	6,
    false,
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/vertical-empty-cradle.png",
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/vertical-empty-cradle.png",
	128,
	256
);
local horizontal_intermodal_cradle = MakeCradle(
    "horizontal-intermodal-cradle",
    "aa",
	{ "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable",
	"no-automated-item-removal", "no-automated-item-insertion", "not-selectable-in-game" },
    6,
	2,
    true,
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/horizontal-intermodal-cradle.png",
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/horizontal-intermodal-cradle.png",
	256,
	128
);
local vertical_intermodal_cradle = MakeCradle(
    "vertical-intermodal-cradle",
    "aa",
    { "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable",
	"no-automated-item-removal", "no-automated-item-insertion", "not-selectable-in-game" },
    2,
	6,
    true,
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/vertical-intermodal-cradle.png",
    "__intermodal-containers-and-gantry__/graphics/entity/intermodal-cradle/vertical-intermodal-cradle.png",
	128,
	256
);


data:extend({horizontal_empty_cradle, vertical_empty_cradle, horizontal_intermodal_cradle, vertical_intermodal_cradle});
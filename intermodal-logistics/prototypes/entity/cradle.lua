local pictures = {
	horizontal = {
		filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/horizontal-intermodal-cradle.png",
		priority = "very-low",
		width = 256,
		height = 128,
		hr_version =
		{
			filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/horizontal-intermodal-cradle.png",
			priority = "very-low",
			width = 256,
			height = 128,
			scale = 1,
		},
	},
	empty_horizontal = {
		filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/horizontal-empty-cradle.png",
		priority = "very-low",
		width = 256,
		height = 128,
		hr_version =
		{
			filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/horizontal-empty-cradle.png",
			priority = "very-low",
			width = 256,
			height = 128,
			scale = 1,
		},
	},
	empty_vertical = {
		filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/vertical-empty-cradle.png",
		priority = "very-low",
		width = 128,
		height = 256,
		hr_version =
		{
			filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/vertical-empty-cradle.png",
			priority = "very-low",
			width = 128,
			height = 256,
			scale = 1,
		},
	},
	vertical = {
		filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/vertical-intermodal-cradle.png",
		priority = "very-low",
		width = 128,
		height = 256,
		hr_version =
		{
			filename = "__intermodal-logistics__/graphics/entity/intermodal-cradle/vertical-intermodal-cradle.png",
			priority = "very-low",
			width = 128,
			height = 256,
			scale = 1,
		},
	},
}


local icon_size = 32;
local icon = "__intermodal-logistics__/graphics/icon/intermodal-cradle.png";

local flags = { "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable" };
local empty_flags = { "placeable-neutral", "player-creation", "not-upgradable", "not-rotatable",
	"no-automated-item-removal", "no-automated-item-insertion", "not-selectable-in-game" };

local horizontal_collision_box = { { -2.9, -0.9 }, { 2.9, 0.9 } };
local horizontal_selection_box = { { -3.0, -1.0 }, { 3.0, 1.0 } };

local vertical_collision_box = { { -0.9, -2.9 }, { 0.9, 2.9 } };
local vertical_selection_box = { { -1.0, -3.0 }, { 1.0, 3.0 } };

-- yoinked from sounds.impact_generic
local vehicle_impact_sound = {
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
};

local empty_placeable_by = {
	item = "intermodal-cradle",
	count = 1,
};

local placeable_by = {
	{
		item = "intermodal-cradle",
		count = 1,
	},
	--[[ {
		item = "intermodal-container",
		count = 1,
	}, ]]
};

local minable = {
	mining_time = 1,
	results =
	{
		{
			type = "item",
			name = "intermodal-cradle",
			amount = 1,
		},
		--[[    {	
			type = "item",
			name = "intermodal-container",
			amount = 1,
		} ]]
	},
};

local empty_minable = {
	mining_time = 1,
	results =
	{
		{
			type = "item",
			name = "intermodal-cradle",
			amount = 1,
		},
	},
};


local resistances = {
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
};
local health = 250;
local inventory_size = 40;

local circuit_wire_connection_point = {
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
};

local circuit_wire_max_distance = 8;

data:extend {
	{
		type = "simple-entity-with-owner",
		name = "cradle-dummy",
		icon_size = icon_size,
		icon = icon,
		flags = { "placeable-neutral", "player-creation", "not-upgradable", },
		picture = {
			north = pictures.empty_horizontal,
			south = pictures.empty_horizontal,
			east = pictures.empty_vertical,
			west = pictures.empty_vertical,
		},
		placeable_by = empty_placeable_by;
		minable = empty_minable;
		collision_box = horizontal_collision_box,
		selection_box = horizontal_selection_box,
	},
	{
		-- Base
		type = "container",
		name = "horizontal-empty-cradle",
		order = "aa",

		-- Entity
		icon_size = icon_size,
		icon = icon,
		flags = empty_flags,
		-- build_sound = { filename = "__intermodal-logistics__/sounds/cradle-place.ogg" },
		-- open_sound =  { filename = "__intermodal-logistics__/sounds/intermodal-open.ogg" },
		-- close_sound = { filename = "__intermodal-logistics__/sounds/intermodal-close.ogg" },
		collision_box = horizontal_collision_box,
		selection_box = horizontal_selection_box,
		shooting_cursor_size = 50,
		--subgroup = "intermodal-cradle",
		vehicle_impact_sound = vehicle_impact_sound,
		placeable_by = empty_placeable_by;
		minable = empty_minable;

		-- Entity with Health
		alert_when_damaged = true,
		--corpse = "intermodal-container",
		create_ghost_on_death = true,
		max_health = health,
		resistances = resistances,

		-- Entity with Owner

		-- Container
		inventory_size = 0,
		picture = pictures.empty_horizontal,
		--circuit_connector_sprites = circuit_connector_sprites,
		circuit_wire_connection_point = circuit_wire_connection_point,
		circuit_wire_max_distance = circuit_wire_max_distance,
	},
	{
		-- Base
		type = "container",
		name = "horizontal-intermodal-cradle",
		order = "aa",

		-- Entity
		icon_size = icon_size,
		icon = icon,
		flags = flags,
		-- build_sound = { filename = "__intermodal-logistics__/sounds/cradle-place.ogg" },
		-- open_sound =  { filename = "__intermodal-logistics__/sounds/intermodal-open.ogg" },
		-- close_sound = { filename = "__intermodal-logistics__/sounds/intermodal-close.ogg" },
		collision_box = horizontal_collision_box,
		selection_box = horizontal_selection_box,
		shooting_cursor_size = 50,
		--subgroup = "intermodal-cradle",
		vehicle_impact_sound = vehicle_impact_sound,
		placeable_by = placeable_by;
		minable = minable;

		-- Entity with Health
		alert_when_damaged = true,
		--corpse = "intermodal-container",
		create_ghost_on_death = true,
		max_health = health,
		resistances = resistances,

		-- Entity with Owner

		-- Container
		inventory_size = inventory_size,
		picture = pictures.horizontal,
		--circuit_connector_sprites = circuit_connector_sprites,
		circuit_wire_connection_point = circuit_wire_connection_point,
		circuit_wire_max_distance = circuit_wire_max_distance,
	},
	{
		-- Base
		type = "container",
		name = "vertical-empty-cradle",
		order = "aa",

		-- Entity
		icon_size = icon_size,
		icon = icon,
		flags = empty_flags,
		-- build_sound = { filename = "__intermodal-logistics__/sounds/cradle-place.ogg" },
		-- open_sound =  { filename = "__intermodal-logistics__/sounds/intermodal-open.ogg" },
		-- close_sound = { filename = "__intermodal-logistics__/sounds/intermodal-close.ogg" },
		collision_box = vertical_collision_box,
		selection_box = vertical_selection_box,
		shooting_cursor_size = 50,
		--subgroup = "intermodal-cradle",
		vehicle_impact_sound = vehicle_impact_sound,
		placeable_by = empty_placeable_by;
		minable = empty_minable;

		-- Entity with Health
		alert_when_damaged = true,
		--corpse = "intermodal-container",
		create_ghost_on_death = true,
		max_health = health,
		resistances = resistances,

		-- Entity with Owner

		-- Container
		inventory_size = 0,
		picture = pictures.empty_vertical,
		--circuit_connector_sprites = circuit_connector_sprites,
		circuit_wire_connection_point = circuit_wire_connection_point,
		circuit_wire_max_distance = circuit_wire_max_distance,
	},
	{
		-- Base
		type = "container",
		name = "vertical-intermodal-cradle",
		order = "aa",

		-- Entity
		icon_size = icon_size,
		icon = icon,
		flags = flags,
		-- build_sound = { filename = "__intermodal-logistics__/sounds/cradle-place.ogg" },
		-- open_sound =  { filename = "__intermodal-logistics__/sounds/intermodal-open.ogg" },
		-- close_sound = { filename = "__intermodal-logistics__/sounds/intermodal-close.ogg" },
		collision_box = vertical_collision_box,
		selection_box = vertical_selection_box,
		shooting_cursor_size = 50,
		--subgroup = "intermodal-cradle",
		vehicle_impact_sound = vehicle_impact_sound,
		placeable_by = placeable_by;
		minable = minable;

		-- Entity with Health
		alert_when_damaged = true,
		--corpse = "intermodal-container",
		create_ghost_on_death = true,
		max_health = health,
		resistances = resistances,

		-- Entity with Owner

		-- Container
		inventory_size = inventory_size,
		picture = pictures.vertical,
		--circuit_connector_sprites = circuit_connector_sprites,
		circuit_wire_connection_point = circuit_wire_connection_point,
		circuit_wire_max_distance = circuit_wire_max_distance,
	},
};

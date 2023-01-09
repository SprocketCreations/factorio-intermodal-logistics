local init_globals = require("scripts.globals");
local make_gantry_prototype_object = require("scripts.prototype-objects.gantry");
local make_cradle_prototype_object = require("scripts.prototype-objects.cradle");
local make_flatbed_prototype_object = require("scripts.prototype-objects.flatbed");
local init_prototypes = require("scripts.init-prototypes");
local create_cradle = require("scripts.create_cradle");
-- This is the main control script.
-- It just sets all the event handlers
--to functions in other files.

local add_filter_gui = require("scripts.gui.gantry-filters-gui");
local add_condition_gui = require("scripts.gui.gantry-conditions-gui");

local function remove_interface(player)
	local frame = player.gui.relative.container_frame;
	if (frame ~= nil) then
		frame.destroy();
	end
end

local function build_interface(player)
	local frame = player.gui.relative.add {
		type = "frame",
		name = "container_frame",
		direction = "vertical",
		visible = true,
		anchor =
		{
			gui = defines.relative_gui_type.container_gui,
			position = defines.relative_gui_position.right,
		},
		caption = "Gantry settings",
	};

	add_filter_gui(frame);
	add_condition_gui(frame);
end

local function init_prototype_globals()
	gantry_prototype = {
		socket_prototypes = {},
		gantry_prototypes = {},
		cradle_prototypes = {},
		flatbed_prototypes = {},
	};
	init_prototypes();
end

remote.add_interface("register_prototypes", {
	register_gantry = make_gantry_prototype_object,
	register_cradle = make_cradle_prototype_object,
	register_flatbed = make_flatbed_prototype_object,
});

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity
}, function(event)
	--[[event contains :
			created_entity	:: LuaEntity
			player_index	:: uint
			stack	:: LuaItemStack
			item	:: LuaItemPrototype?
			The item prototype used to build the entity. Note this won't exist in some situations (built from blueprint, undo, etc).
			tags	:: Tags?
			The tags associated with this entity if any.
			name	:: defines.events
			Identifier of the event
			tick	:: uint
			Tick the event was generated.]]

	local object = gantry_prototype.socket_prototypes[event.created_entity.name];
	local switch = {
		cradle = function()
			-- two steps:
			-- 1. replace dummy prototype with real prototype
			local direction = event.created_entity.direction;
			if (direction == defines.direction.east or direction == defines.direction.west) then
				--east
				create_cradle(
					event.created_entity,
					object.empty_vertical_prototype_name);
			else
				--north
				create_cradle(
					event.created_entity,
					object.empty_horizontal_prototype_name);
			end
			-- 2. create and link socket object
		end,
		flatbed = function()

		end,
		cargoship = function()

		end,
	};

	if (object ~= nil) then
		local handler = switch[object.type];
		if (handler == nil) then
			error("no handler found for socket type " + object.type);
		elseif(object.placement_dummy_prototype_name == event.created_entity.name)  then
			handler();
		end
	end

end);

commands.add_command("rebuild_gui", nil, function(command)
	local player = game.get_player(command.player_index);
	remove_interface(player);
	build_interface(player);
end);

commands.add_command("reload_globals", nil, function(command)
	init_globals();
end)

script.on_configuration_changed(function(data)
	if (data.mod_changes["intermodal-containers-and-ganty"]) then
		for _, player in pairs(game.players) do
			remove_interface(player);
			build_interface(player);
		end
	end
end)

script.on_init(function()
	init_globals();
	init_prototype_globals();
	for _, player in pairs(game.players) do
		build_interface(player);
	end
end);


script.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index);
	build_interface(player);
end);


script.on_load(function()
	init_prototype_globals();
end);

script.on_event(defines.events.on_player_setup_blueprint, function(event)
	local player = game.get_player(event.player_index);
	local entities = player.cursor_stack.get_blueprint_entities();
	local blueprint = player.cursor_stack;
	local cradle_entities = {};
	for _, entity in pairs(entities) do
		local object = gantry_prototype.socket_prototypes[entity.name];
		if (object ~= nil) then
			table.insert(cradle_entities, { entity = entity, object = object });
		end
	end

	if (#cradle_entities ~= 0) then
		blueprint.clear_blueprint();
		for _, ent in pairs(cradle_entities) do
			local entity = ent.entity;
			local object = ent.object;
			local dummy = object.placement_dummy_prototype_name;
			if (dummy ~= nil) then

				if (
					entity.name == object.empty_horizontal_prototype_name or
						entity.name == object.containered_horizontal_prototype_name) then
					entity.direction = 4; --hor
				else -- vertical
					entity.direction = 2; --vert
				end
				entity.name = dummy;
				entity.variation = 1;
			end
		end

		blueprint.set_blueprint_entities(entities);
	end
end);

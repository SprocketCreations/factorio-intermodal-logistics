-- Remotes
local make_gantry_prototype_object = require("scripts.prototype-objects.gantry");
local make_cradle_prototype_object = require("scripts.prototype-objects.cradle");
local make_flatbed_prototype_object = require("scripts.prototype-objects.flatbed");

-- Initializers
local init_globals = require("scripts.globals");
local remove_interface, build_interface = table.unpack(require("scripts.interface"));
local init_prototype_globals = require("scripts.init-prototype-globals");

-- Events
local on_build_entity = require("scripts.event.on-build-entity");
local on_destroy_entity = require("scripts.event.on-destroy-entity");
local on_blueprint_setup = require("scripts.event.on-blueprint-setup");

-- This is the main control script.
-- It just sets all the event handlers
--to functions in other files.


remote.add_interface("register_prototypes", {
	register_gantry = make_gantry_prototype_object,
	register_cradle = make_cradle_prototype_object,
	register_flatbed = make_flatbed_prototype_object,
});

script.on_event({
	defines.events.on_player_mined_entity,
	defines.events.on_robot_mined_entity,
	defines.events.on_entity_died
}, on_destroy_entity);

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity
}, on_build_entity);

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

script.on_event(defines.events.on_player_setup_blueprint, on_blueprint_setup);


script.on_event(defines.events.on_gui_elem_changed, function (event)
	if(event.element.parent.name == "gantry_request_filters") then
		-- Get the socket accociated with the entity we have opened.
		local socket = global.sockets[game.get_player(event.element.player_index).opened.unit_number];
		-- Get the filter
		local value = event.element.elem_value;
		-- Get the button index
		local index = event.element.index - event.element.parent.index;
		-- Set the filter to the new value;
		socket:set_filter(index, value);
	end
end)

script.on_event(defines.events.on_gui_opened, function(event)
	if(event.gui_type == defines.gui_type.entity) then
		local socket = global.sockets[event.entity.unit_number];
		if(socket ~= nil) then
			local player = game.get_player(event.player_index);
			-- This line makes me cry
			local filter_buttons = player.gui.relative.socket_configuration.gantry_filters.invisible_frame.scroll_pane.logistic_background.gantry_request_filters.children;
			for index, filter_button in pairs(filter_buttons) do
				filter_button.elem_value = socket:get_filter(index);
			end
		end
	end
end);
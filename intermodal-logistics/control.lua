-- Initializers
require("scripts.intermodal-logistics-game");
require("scripts.interface");
require("scripts.globals");

-- Events
require("scripts.event.on-build-entity");
require("scripts.event.on-destroy-entity");
require("scripts.event.on-blueprint-setup");
require("scripts.event.on-gui-text-changed");
require("scripts.event.on-gui-confirmed");
require("scripts.event.on-gui-checked-state-changed");
require("scripts.event.on-gui-elem-changed");
require("scripts.event.on-gui-opened");
require("scripts.event.on-gui-selection-state-changed");
require("scripts.event.on-gui-click");



local function on_first_tick(event)
	script.on_event(defines.events.on_tick, nil);
	parse_data_pipeline();
end

-- This is the main control script.
-- It just sets all the event handlers
--to functions in other files.


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
	if (data.mod_changes["intermodal-logistics"]) then
		for _, player in pairs(game.players) do
			remove_interface(player);
			build_interface(player);
		end
	end
end);

script.on_init(function()
	-- Set the on first tick event.
	script.on_event(defines.events.on_tick, on_first_tick);
	-- Create all the global tables
	init_static_globals();
	init_transient_globals();
	-- Give every player the custom guis
	for _, player in pairs(game.players) do
		build_interface(player);
	end
end);

script.on_load(function()
	-- Set the on first tick event.
	script.on_event(defines.events.on_tick, on_first_tick);
	-- Create all the global tables
	init_transient_globals();
end);

script.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index);
	-- Give each new player the custom gui
	build_interface(player);
end);

-- Blueprint stuff
script.on_event(defines.events.on_player_setup_blueprint, on_blueprint_setup);

-- Gui stuff
script.on_event(defines.events.on_gui_elem_changed, on_gui_elem_changed);
script.on_event(defines.events.on_gui_opened, on_gui_opened);
script.on_event(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed);
script.on_event(defines.events.on_gui_click, on_gui_click);
script.on_event(defines.events.on_gui_checked_state_changed, on_gui_checked_state_changed);
script.on_event(defines.events.on_gui_text_changed, on_gui_text_changed);
script.on_event(defines.events.on_gui_confirmed, on_gui_confirmed);

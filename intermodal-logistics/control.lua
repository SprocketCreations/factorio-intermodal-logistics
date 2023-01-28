-- Remotes
require("scripts.prototype-objects.gantry");
require("scripts.prototype-objects.cradle");
require("scripts.prototype-objects.flatbed");

-- Initializers
require("scripts.globals");
require("scripts.interface");
require("scripts.init-prototype-globals");

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

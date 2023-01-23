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


local add_filter_button_row = require("scripts.gui.gantry-filters-gui")[2];
local add_condition_to_element = require("scripts.gui.gantry-conditions-gui")[2];
local regenerate_conditions = require("scripts.gui.gantry-conditions-gui")[3];

-- This is the main control script.
-- It just sets all the event handlers
--to functions in other files.

local get_gantry_request_filters_gui = function(player)
	return player.gui.relative.socket_configuration.gantry_filters.invisible_frame.scroll_pane.logistic_background.gantry_request_filters;
end

local get_gantry_conditions_flow = function(player)
	return player.gui.relative.socket_configuration.conditions_outer_frame.invisible_frame.tabbed_pane.schedule_scroll_pane
		.fake_train_station.fake_train_station_conditions_flow;
end

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


script.on_event(defines.events.on_gui_elem_changed, function(event)
	-- Gantry Filters
	if (event.element.parent.name == "gantry_request_filters") then
		local player = game.get_player(event.element.player_index);
		-- Get the socket accociated with the entity we have opened.
		local socket = global.sockets[player.opened.unit_number];
		-- Get the filter
		local value = event.element.elem_value;
		-- Get the button index
		local index = event.element.get_index_in_parent();
		local number_of_buttons = #(event.element.parent.children);
		-- If this picker is on the last row and we are adding a value
		if (index > number_of_buttons - 10 and value ~= nil) then
			-- we want to add another row
			add_filter_button_row(get_gantry_request_filters_gui(player), 1);
		end
		-- Set the filter to the new value;
		socket:set_filter(index, value);
	end
	-- Gantry Conditons
end)

script.on_event(defines.events.on_gui_opened, function(event)
	if (event.gui_type == defines.gui_type.entity) then
		local socket = global.sockets[event.entity.unit_number];
		if (socket ~= nil) then
			-- Gantry Filters
			local player = game.get_player(event.player_index);
			local gantry_request_filters_gui = get_gantry_request_filters_gui(player);
			-- Remove all the buttons
			gantry_request_filters_gui.clear();
			-- Then re-add two rows
			add_filter_button_row(gantry_request_filters_gui, 2);
			for index, filter in pairs(socket.filters) do
				-- if we have run out of buttons
				if (index + 10 > #(gantry_request_filters_gui.children)) then
					-- Add more rows
					local rows_to_add = math.ceil((index + 10 - #(gantry_request_filters_gui.children)) / 10);
					add_filter_button_row(gantry_request_filters_gui, rows_to_add);
				end
				gantry_request_filters_gui.children[index].elem_value = filter;
			end
			-- Gantry Conditons
			local gantry_conditions_flow = get_gantry_conditions_flow(player);
			regenerate_conditions(gantry_conditions_flow, socket.conditionals);
		end
	end
end);

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
	if (event.element.name == "gantry_condition_add_dropdown") then
		local player = game.get_player(event.player_index);
		do -- Add a button to the gui to reflect the new condition
			local flow = get_gantry_conditions_flow(player);
			local switch = {
				"time-elapsed",
				"inactivity",
				"full-cargo",
				"empty-cargo",
				"item-count",
				"circuit-condition",
			};
			add_condition_to_element(flow, switch[event.element.selected_index]);
		end
		do -- Update the socket with the new condition
			local socket = global.sockets[player.opened.unit_number];
			local switch = {
				socket.conditionals.add_time_elapsed_condition,
				socket.conditionals.add_inactivity_condition,
				socket.conditionals.add_full_condition,
				socket.conditionals.add_empty_condition,
				socket.conditionals.add_item_count_condition,
				socket.conditionals.add_circuit_condition,
			};
			switch[event.element.selected_index](socket.conditionals);
		end
	end
end);

script.on_event(defines.events.on_gui_click, function(event)
	if(event.button == defines.mouse_button_type.left) then
		-- A bunch of data useful in the rest of the function.
		local player = game.get_player(event.player_index);
		local entity = player.opened;
		local socket = global.sockets[entity.unit_number];
		local conditionals = socket.conditionals;
		local condition_root = get_gantry_conditions_flow(player);
		-- Lua switch statement
		local switch = {};
		-- Up button
		switch["gantry_condition_up_button"] = function()
			
		end;
		-- Delete Button
		switch["gantry_condition_delete_button"] = function()
			local index = event.element.parent.parent.get_index_in_parent();
			conditionals:remove_condition(index);
			regenerate_conditions(condition_root, conditionals);
		end;

		switch[event.element.name]();
	end
end);
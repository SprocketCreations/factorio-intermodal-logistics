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
		return;
	end
	-- Gantry Conditons
	do
		local switch = {
			["gantry_choose_item_button_left"] = function()
				local player = game.get_player(event.element.player_index);
				local socket = global.sockets[player.opened.unit_number];
				local index = event.element.parent.parent.parent.parent.get_index_in_parent();
				local item = event.element.elem_value;
				local condition = socket.conditionals:get_condition(index);
				condition.left_item = item;
			end,
			["gantry_choose_signal_button_left"] = function()
				local player = game.get_player(event.element.player_index);
				local socket = global.sockets[player.opened.unit_number];
				local index = event.element.parent.parent.parent.parent.get_index_in_parent();
				local signal = event.element.elem_value;
				local condition = socket.conditionals:get_condition(index);
				condition.left_signal = signal;
			end,
			["gantry_choose_signal_button_right"] = function()
				local player = game.get_player(event.element.player_index);
				local socket = global.sockets[player.opened.unit_number];
				local index = event.element.parent.parent.parent.parent.get_index_in_parent();
				local signal = event.element.elem_value;
				local condition = socket.conditionals:get_condition(index);
				condition.right_signal = signal;
			end,
		};
		local func = switch[event.element.name];
		if (func ~= nil) then func() end
	end
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

		-- Update the socket with the new condition
		local socket = global.sockets[player.opened.unit_number];
		local switch = {
			socket.conditionals.add_inactivity_condition,
			socket.conditionals.add_time_elapsed_condition,
			socket.conditionals.add_full_condition,
			socket.conditionals.add_empty_condition,
			socket.conditionals.add_item_count_condition,
			socket.conditionals.add_circuit_condition,
		};
		local condition = switch[event.element.selected_index](socket.conditionals);
		event.element.selected_index = 0;
		-- Add a button to the gui to reflect the new condition
		local flow = get_gantry_conditions_flow(player);
		add_condition_to_element(flow, condition);

	end

	if (event.element.name == "gantry_comparison_operator_dropdown") then
		local player = game.get_player(event.player_index);
		local socket = global.sockets[player.opened.unit_number];
		local conditionals = socket.conditionals;

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.comparitor = event.element.selected_index;
	end
end);

script.on_event(defines.events.on_gui_click, function(event)
	if (event.button == defines.mouse_button_type.left) then
		-- A bunch of data useful in the rest of the function.
		local player = game.get_player(event.player_index);
		local entity = player.opened;
		local socket = global.sockets[entity.unit_number];
		local conditionals = socket.conditionals;
		local condition_root = get_gantry_conditions_flow(player);
		-- Lua switch statement
		local switch = {};
		-- Time elapsed field
		switch["gantry_time_elapsed_customize_field"] = function()
			event.element.text = string.sub(event.element.text, 1, #(event.element.text) - 2);
		end
		-- Constant text field
		switch["gantry_constant_textfield"] = function()
			local index = event.element.parent.parent.parent.parent.get_index_in_parent();
			local condition = conditionals:get_condition(index);

			event.element.text = tostring(condition.constant);
		end
		-- Operator toggle button
		switch["gantry_comparison_operator_button"] = function()
			local index = event.element.parent.parent.parent.get_index_in_parent();
			conditionals:toggle_comparison_operator(index);
			regenerate_conditions(condition_root, conditionals);
		end;
		-- Down button
		switch["gantry_condition_down_button"] = function()
			-- Better than Minecraft's gui system at least
			local parent = event.element.parent.parent.parent.parent;
			local index = parent.get_index_in_parent();
			if (index ~= #(parent.parent.children)) then
				conditionals:move_condition_down(index);
				regenerate_conditions(condition_root, conditionals);
			end
		end;
		-- Up button
		switch["gantry_condition_up_button"] = function()
			local index = event.element.parent.parent.parent.parent.get_index_in_parent();
			if (index ~= 1) then
				conditionals:move_condition_up(index);
				regenerate_conditions(condition_root, conditionals);
			end
		end;
		-- Delete Button
		switch["gantry_condition_delete_button"] = function()
			local index = event.element.parent.parent.get_index_in_parent();
			conditionals:remove_condition(index);
			regenerate_conditions(condition_root, conditionals);
		end;

		local func = switch[event.element.name];
		if (func ~= nil) then func(); end
	end
end);


script.on_event(defines.events.on_gui_checked_state_changed, function(event)
	if (event.element.name == "gantry_use_constant_checkbox") then
		local player = game.get_player(event.player_index);
		local socket = global.sockets[player.opened.unit_number];
		local conditionals = socket.conditionals;

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.use_constant = not (condition.use_constant);

		local condition_root = get_gantry_conditions_flow(player);
		regenerate_conditions(condition_root, conditionals);
	end
end);

script.on_event(defines.events.on_gui_text_changed, function(event)
	if (event.element.name == "gantry_time_elapsed_customize_field") then
		local time = tonumber(event.text);

		local player = game.get_player(event.player_index);
		local socket = global.sockets[player.opened.unit_number];
		local conditionals = socket.conditionals;

		local index = event.element.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.time = time;
	end

	if (event.element.name == "gantry_constant_textfield") then
		local player = game.get_player(event.player_index);
		local socket = global.sockets[player.opened.unit_number];
		local conditionals = socket.conditionals;

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.constant = event.element.text;
	end
end);

script.on_event(defines.events.on_gui_confirmed, function(event)
	if (event.element.name == "gantry_time_elapsed_customize_field") then
		event.element.text = event.element.text .. " s";
	end

	if (event.element.name == "gantry_constant_textfield") then
		local value = tonumber(event.element.text);
		local text = "";
		if (value >= 1000000000) then
			-- Billion
			local value = math.floor(value / 100000000) / 10;
			text = tostring(value);
			if(value == math.floor(value)) then
				text = text .. ".0";
			end
			text = text .. "G";
		elseif (value >= 100000000) then
			-- Hundred Million
			text = tostring(math.floor(value / 1000000)) .. "M";
		elseif (value >= 10000000) then
			-- Ten Million
			text = tostring(math.floor(value / 1000000)) .. "M";
		elseif (value >= 1000000) then
			-- Million
			local value = math.floor(value / 100000) / 10;
			text = tostring(value);
			if(value == math.floor(value)) then
				text = text .. ".0";
			end
			text = text .. "M";
		elseif (value >= 100000) then
			-- Hundren Thousand
			text = tostring(math.floor(value / 1000)) .. "k";
		elseif (value >= 10000) then
			-- Ten Thousand
			text = tostring(math.floor(value / 1000)) .. "k";
		elseif (value >= 1000) then
			-- Thousand
			local value = math.floor(value / 100) / 10;
			text = tostring(value);
			if(value == math.floor(value)) then
				text = text .. ".0";
			end
			text = text .. "k";
		else
			-- Hundreds and so on
			text = event.element.text;
		end
		event.element.text = text;
	end
end);

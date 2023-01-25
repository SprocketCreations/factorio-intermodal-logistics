
local regenerate_conditions = require("scripts.gui.gantry-conditions-gui")[3];

local get_gui_stuff = require("scripts.util.get-gui-stuff");
local get_gantry_conditions_flow = require("scripts.util.get-gantry-conditions-flow");

local on_gui_click = function(event)
	if (event.button == defines.mouse_button_type.left) then
		-- A bunch of data useful in the rest of the function.
		local player, socket, conditionals = get_gui_stuff(event.player_index);
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
end

return on_gui_click;

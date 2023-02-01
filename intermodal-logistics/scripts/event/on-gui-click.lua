
require("scripts.gui.gantry-conditions-gui");

require("scripts.util.get-gui-stuff");
require("scripts.util.get-gantry-conditions-flow");

function on_gui_click(event)
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
			local condition = conditional_get_condition(conditionals, index);

			event.element.text = tostring(condition.constant);
		end
		-- Operator toggle button
		switch["gantry_comparison_operator_button"] = function()
			local index = event.element.parent.parent.parent.get_index_in_parent();
			conditional_toggle_comparison_operator(conditionals, index);
			regenerate_conditions(condition_root, conditionals);
		end;
		-- Down button
		switch["gantry_condition_down_button"] = function()
			-- Better than Minecraft's gui system at least
			local parent = event.element.parent.parent.parent.parent;
			local index = parent.get_index_in_parent();
			if (index ~= #(parent.parent.children)) then
				conditional_move_condition_down(conditionals, index);
				regenerate_conditions(condition_root, conditionals);
			end
		end;
		-- Up button
		switch["gantry_condition_up_button"] = function()
			local index = event.element.parent.parent.parent.parent.get_index_in_parent();
			if (index ~= 1) then
				conditional_move_condition_up(conditionals, index);
				regenerate_conditions(condition_root, conditionals);
			end
		end;
		-- Delete Button
		switch["gantry_condition_delete_button"] = function()
			local index = event.element.parent.parent.get_index_in_parent();
			conditional_remove_condition(conditionals, index);
			regenerate_conditions(condition_root, conditionals);
		end;

		local handler = switch[event.element.name];
		if (handler ~= nil) then handler(); end
	end
end

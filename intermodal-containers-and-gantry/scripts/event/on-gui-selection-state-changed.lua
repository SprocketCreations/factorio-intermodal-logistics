
local add_condition_to_element = require("scripts.gui.gantry-conditions-gui")[2];

local get_gui_stuff = require("scripts.util.get-gui-stuff");
local get_gantry_conditions_flow = require("scripts.util.get-gantry-conditions-flow");

local on_gui_selection_state_changed = function(event)
	if (event.element.name == "gantry_condition_add_dropdown") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		-- Update the socket with the new condition
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
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.comparitor = event.element.selected_index;
	end
end;

return on_gui_selection_state_changed;

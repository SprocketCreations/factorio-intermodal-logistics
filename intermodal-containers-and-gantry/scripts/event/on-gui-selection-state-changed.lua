
require("scripts.gui.gantry-conditions-gui");

require("scripts.util.get-gui-stuff");
require("scripts.util.get-gantry-conditions-flow");

function on_gui_selection_state_changed(event)
	if (event.element.name == "gantry_condition_add_dropdown") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		-- Update the socket with the new condition
		local switch = {
			conditional_add_inactivity_condition,
			conditional_add_time_elapsed_condition,
			conditional_add_full_condition,
			conditional_add_empty_condition,
			conditional_add_item_count_condition,
			conditional_add_circuit_condition,
		};
		local condition = switch[event.element.selected_index](conditionals);
		event.element.selected_index = 0;
		-- Add a button to the gui to reflect the new condition
		local flow = get_gantry_conditions_flow(player);
		add_condition_to_element(flow, condition);
	end

	if (event.element.name == "gantry_comparison_operator_dropdown") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditional_get_condition(conditionals, index);

		condition.comparitor = event.element.selected_index;
	end
end;

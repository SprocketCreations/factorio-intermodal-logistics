
require("scripts.util.get-gui-stuff");
require("scripts.gui.gantry-conditions-gui");
require("scripts.util.get-gantry-conditions-flow");

function on_gui_checked_state_changed(event) 
	if (event.element.name == "gantry_use_constant_checkbox") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditional_get_condition(conditionals, index);

		condition.use_constant = not (condition.use_constant);

		local condition_root = get_gantry_conditions_flow(player);
		regenerate_conditions(condition_root, conditionals);
	end
end


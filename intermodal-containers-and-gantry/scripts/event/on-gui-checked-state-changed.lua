
local get_gui_stuff = require("scripts.util.get-gui-stuff");
local regenerate_conditions = require("scripts.gui.gantry-conditions-gui")[3];
local get_gantry_conditions_flow = require("scripts.util.get-gantry-conditions-flow");

local on_gui_checked_state_changed = function(event) 
	if (event.element.name == "gantry_use_constant_checkbox") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.use_constant = not (condition.use_constant);

		local condition_root = get_gantry_conditions_flow(player);
		regenerate_conditions(condition_root, conditionals);
	end
end

return on_gui_checked_state_changed;

local get_gui_stuff = require("scripts.util.get-gui-stuff");

local on_gui_text_changed = function (event)
	if (event.element.name == "gantry_time_elapsed_customize_field") then
		local time = tonumber(event.text);

		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.time = tonumber(time);
	end

	if (event.element.name == "gantry_constant_textfield") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditionals:get_condition(index);

		condition.constant = tonumber(event.element.text);
	end
end

return on_gui_text_changed;

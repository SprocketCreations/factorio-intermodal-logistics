require("scripts.util.get-gui-stuff");

function on_gui_text_changed(event)
	if (event.element.name == "gantry_time_passed_customize_field") then
		local time = tonumber(event.text);

		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.get_index_in_parent();
		local condition = conditional_get_condition(conditionals, index);

		condition.time = tonumber(time);
	end

	if (event.element.name == "gantry_constant_textfield") then
		local player, socket, conditionals = get_gui_stuff(event.player_index);

		local index = event.element.parent.parent.parent.parent.get_index_in_parent();
		local condition = conditional_get_condition(conditionals, index);

		condition.constant = tonumber(event.element.text);
	end
end

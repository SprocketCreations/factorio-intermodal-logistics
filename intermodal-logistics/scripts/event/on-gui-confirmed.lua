require("scripts.util.number-prettier");

function on_gui_confirmed(event)
	if (event.element.name == "gantry_time_passed_customize_field") then
		event.element.text = event.element.text .. " s";
	end

	if (event.element.name == "gantry_constant_textfield") then
		event.element.text = prettify_number(tonumber(event.element.text))
	end
end

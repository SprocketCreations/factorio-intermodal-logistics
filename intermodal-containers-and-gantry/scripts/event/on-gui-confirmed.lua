local prettify_number = require("scripts.util.number-prettier");

local on_gui_confirmed = function (event)
	if (event.element.name == "gantry_time_elapsed_customize_field") then
		event.element.text = event.element.text .. " s";
	end

	if (event.element.name == "gantry_constant_textfield") then
		event.element.text = prettify_number(tonumber(event.element.text))
	end
end

return on_gui_confirmed;

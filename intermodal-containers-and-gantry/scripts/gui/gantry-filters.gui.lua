--[[ HTML PSEUDO REP OF THIS FRAME
<frame light-gray>
<label>
Gantry request
</label>
<frame dark-gray inset>
<list>
<item-filter-slot x20>
</list>
</frame>
</frame> ]]

local filter_gui = {};

local outer_frame = {
	type = "frame",
	name = "outer_frame",
	tyle = "inside_shallow_frame_with_padding",
	direction = "vertical",
};

local label = outer_frame.add{
	type = "label",
	name = "label",
	caption = {"gui.gantry_request"},
};

local inset_frame = outer_frame.add{
	type = "frame",
	name = "button_table",
	style = "deep_frame_in_shallow_frame",
};

local inset_table = inset_frame.add{
	type = "table",
	name = "button_table",
	style = "filter_slot_table",
	column_count = 10,
};

function addButton()
	local button = {
		type = "sprite-button",
		--name = "button",
		style = "recipe_slot_button",
		index = ,
		sprite = ,
		hovered_sprite = ,
		clicked_sprite = ,
		-- This is the little number displayed in the button
		number = ,
		mouse_button_filter = "left",
	}
	inset_table.add(button);
end

return filter_gui;
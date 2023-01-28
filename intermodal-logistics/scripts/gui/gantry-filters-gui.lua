-- Adds one filter button to the thing
function add_filter_button(table)
	table.add{
		type = "choose-elem-button",
		style = "logistic_slot_button",
		elem_type = "item",
		mouse_button_filter = "left",
	};
end

-- Adds a number of rows equal to the row_count.
-- That is ten buttons per row.
function add_filter_button_row(table, row_count)
	row_count = row_count or 1;
	for i=1, 10 * row_count, 1 do
		add_filter_button(table);
	end
end

-- Takes in an LuaElementGUI as a root
--and builds and attaches the filter
--gui to it as a child.
function add_filter_gui_to_element(root)
	local entity_frame = root.add{
		type = "frame",
		name = "gantry_filters",
		style = "entity_frame_without_right_padding",
		direction = "vertical",
	};

	local logistic_title_frame = entity_frame.add{
		type = "frame",
		name = "invisible_frame",
		direction = "vertical",
		caption = {"gui.gantry-request"},
		style = "container_invisible_frame_with_title",
	};

	local scroll_pane = logistic_title_frame.add{
		type = "scroll-pane",
		name = "scroll_pane",
		direction = "vertical",
		horizontal_scroll_policy = "never",
		vertical_scroll_policy = "auto",
		style = "container_logistics_scroll_pane",
	};

	local background_frame = scroll_pane.add{
		type= "frame",
		name = "logistic_background",
		direction="vertical",
		style = "logistics_scroll_pane_background_frame",
	}

	local inset_table = background_frame.add{
		type = "table",
		name = "gantry_request_filters",
		style = "filter_slot_table",
		column_count = 10,
	};
	
	add_filter_button_row(inset_table, 2);
end

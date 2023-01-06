
-- Takes in an LuaElementGUI as a root
--and builds and attaches the filter
--gui to it as a child.
local addFilterGUIToElement = function(root)
	local entity_frame = root.add{
		type = "frame",
		name = "filter_outer_frame",
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
		name = "table",
		style = "filter_slot_table",
		column_count = 10,
	};

	-- Adds one button
	local addButton = function()
		inset_table.add{
			type = "choose-elem-button",
			style = "logistic_slot_button",
			elem_type = "item",
			mouse_button_filter = "left",
		};
	end

	-- Adds ten buttons
	local addRow = function()
		for i=1, 10, 1 do
			addButton();
		end
	end

	addRow();
	addRow();
end

return addFilterGUIToElement;
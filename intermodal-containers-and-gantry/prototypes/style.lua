local default = data.raw["gui-style"]["default"]


default.vertical_flow_horizontal_align_right =
{
	type = "vertical_flow_style",
	horizontal_align = "right",
	width = 380,
	natural_width = 380,
};

default.gantry_window_content_in_pane = {
	type = "frame_style",
	parent = "window_content_frame_in_tabbed_panne",
	width = 400,
	natural_width = 400,
	vertically_stretchable = "on",
	left_margin = 0,
	right_margin = 0,
};

default.gantry_condition_scroll_pane = {
	type = "scroll_pane_style",
	parent = "train_schedule_scroll_pane",
	vertically_stretchable = "stretch_and_expand",
	horizontally_squashable = "auto",
};

default.container_invisible_frame_with_title_without_left_padding = {
	type = "frame_style",
	parent = "container_invisible_frame_with_title",
	horizontal_flow_style =
	{
		type = "horizontal_flow_style",
		left_padding = 0,
		top_padding = 5,
	},
	vertical_flow_style =
	{
		type = "vertical_flow_style",
		left_padding = 0,
		top_padding = 5,
	}
};

default.gantry_player_input_horizontal_flow = {
	type = "horizontal_flow_style",
	parent = "player_input_horizontal_flow",
	width = 204,
};

default.gantry_reorder_vertical_flow = {
	type = "vertical_flow_style",
	right_margin = -4,
	left_margin = 0,
	right_padding = 8;
	horizontal_align = "left",
};

default.gantry_reorder_horizontal_flow = {
	type = "horizontal_flow_style",
	horizontal_spacing = 8,
}

default.gantry_reorder_button = {
	type = "button_style",
	parent = "train_schedule_delete_button",
	size = { 16, 28 },
	left_padding = -5;
	right_padding = -5;
	default_graphical_set =
	{
		base = { position = { 68, 0 }, corner_size = 8 },
		shadow = { position = { 440, 24 }, corner_size = 8, draw_type = "outer" },
	}
};

default.gantry_constant_select_button = {
	type = "button_style",
	parent = "train_schedule_item_select_button",
	default_font_color = { 1, 1, 1 },
	hovered_font_color = { 1, 1, 1 },
	clicked_font_color = { 1, 1, 1 },
};

default.gantry_add_wait_condition_button = {
	type = "dropdown_style",
	button_style = {
		type = "button_style",
		parent = "train_schedule_add_wait_condition_button"
	},
	icon = {
		-- No icon
		width = 1,
		height = 1,
	},
	list_box_style = {
		type = "list_box_style",
		vertical_flow_style = {
			type = "vertical_flow_style",
			parent = "frame_with_even_paddings",
		},
	},
};

default.gantry_time_selection_textfield = {
	type = "textbox_style",

	width = 84,
	minimal_height = 28,
	horizontal_align = "center",
	vertical_align = "center",
	top_padding = 0,
	bottom_padding = 0,
	left_padding = 8;
	right_padding = 8;
};

default.gantry_constant_textfield = {
	type = "textbox_style",

	padding = -3,
	height = 28,
	width = 40;

	horizontal_align = "center",
	vertical_align = "center",

	horizontally_stretchable = "on",

	font = "default-semibold",
	font_color = { 1, 1, 1 },
	default_font_color = { 1, 1, 1 },
	hovered_font_color = { 1, 1, 1 },
	clicked_font_color = { 1, 1, 1 },

	default_background = {
		base = { border = 4, position = { 2, 738 }, size = 76 },
		shadow =
		{
			position = { 378, 103 },
			corner_size = 16,
			top_outer_border_shift = 4,
			bottom_outer_border_shift = -4,
			left_outer_border_shift = 4,
			right_outer_border_shift = -4,
			draw_type = "outer"
		}
	};
	active_background = {
		base = { border = 4, position = { 162, 738 }, size = 76 },
		shadow =
		{
			position = { 378, 103 },
			corner_size = 16,
			top_outer_border_shift = 4,
			bottom_outer_border_shift = -4,
			left_outer_border_shift = 4,
			right_outer_border_shift = -4,
			draw_type = "outer"
		}
	};
};

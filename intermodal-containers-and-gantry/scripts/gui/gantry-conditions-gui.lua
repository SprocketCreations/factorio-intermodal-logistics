
local add_comparison_to_condition = function(condition_flow, isAnd, indent_amount)
	local indent_level = {}
	indent_level[0] = "train_schedule_comparison_type_frame";
	indent_level[1] = "train_schedule_comparison_type_frame_indented";
	indent_level[2] = "train_schedule_comparison_type_frame_extra_indented";

	local comparison_condition_frame = condition_flow.add{
		type = "frame",
		style = indent_level[indent_amount],
	};

	local sub_frame = comparison_condition_frame.add{
		type = "flow",
		direction = "horizontal",
	}

	local comparison_button = sub_frame.add{
		type = "button",
		caption = isAnd and {"gui.and"} or {"gui.or"},
		style = "train_schedule_comparison_type_button",
	};
end

local add_condition = function (fake_train_station, conditionLabelFunction, comparitor)
	local condition_flow = fake_train_station.add{
		type = "flow",
		direction = "horizontal",
	};

	if(comparitor) then
		add_comparison_to_condition(condition_flow, comparitor == "AND", comparitor == "OR" and 2 or 1);
	end
	
	local condition_frame = condition_flow.add{
		type = "frame",
		style = "train_schedule_condition_frame",
	};

	local input_flow = condition_frame.add{
		type = "flow",
		direction = "horizontal",
		style = "gantry_player_input_horizontal_flow",
	};

	conditionLabelFunction(input_flow, true);

	local reorder_controls_space = condition_frame.add{
		type = "flow",
		direction = "vertical",
		style = "gantry_reorder_vertical_flow",
	};

	local reorder_controls = reorder_controls_space.add{
		type = "flow",
		direction = "horizontal",
		style = "gantry_reorder_horizontal_flow",
	};

	reorder_controls.add{
		type = "sprite-button",
		name = "up",
		style = "gantry_reorder_button",

		sprite = "up_arrow_sprite",
		hovered_sprite = "up_arrow_dark_sprite",
		clicked_sprite = "up_arrow_dark_sprite",
		mouse_button_filter = {"left"},
	};

	reorder_controls.add{
		type = "sprite-button",
		name = "down",
		style = "gantry_reorder_button",

		sprite = "utility/collapse",
		hovered_sprite = "utility/collapse_dark",
		clicked_sprite = "utility/collapse_dark",
		mouse_button_filter = {"left"},
	};

	local condition_delete_button = condition_frame.add{
		type = "sprite-button",
		style = "train_schedule_delete_button",

		sprite = "utility/close_white",
		hovered_sprite = "utility/close_black",
		clicked_sprite = "utility/close_black",
		mouse_button_filter = {"left"},
	};
end

local add_time_passed_condition_label = function(input_flow)
	input_flow.add{
		type = "button",
		caption = "30 s",
		style = "train_schedule_condition_time_selection_button",
	}
	input_flow.add{
		type = "label",
		caption = {"gui.time-passed"},
		style = "squashable_label",
	};
end

local add_inactivity_condition_label = function(input_flow)
	input_flow.add{
		type = "button",
		caption = "5 s",
		style = "train_schedule_condition_time_selection_button",
	}
	input_flow.add{
		type = "label",
		caption = {"gui.inactivity"},
		style = "squashable_label",
	};
end

local add_full_cargo_condition_label = function(input_flow)
	input_flow.add{
		type = "label",
		caption = {"gui.full-cargo"},
		style = "squashable_label_with_left_padding",
	};
end

local add_empty_cargo_condition_label = function(input_flow)
	input_flow.add{
		type = "label",
		caption = {"gui.empty-cargo"},
		style = "squashable_label_with_left_padding",
	};
end

local add_item_count_condition_label = function(input_flow, constant)
	input_flow.add{
		type = "label",
		caption = {"gui.item-count"},
		style = "squashable_label_with_left_padding",
	};
	input_flow.add{ -- This is just to shove the buttons to the right
		type = "flow",
		style = "relative_gui_top_flow",
	};
	local flow = input_flow.add{
		type = "flow",
		direction = "horizontal",
	};
	flow.add{
		type = "choose-elem-button",
		elem_type = "signal",
		style = "train_schedule_item_select_button",
	};
	flow.add{
		type = "drop-down",
		style = "circuit_condition_comparator_dropdown",
		items = {
			">",
			"<",
			"=",
			"≥",
			"≤",
			"≠"
		},
		selected_index = 2,
	};
	if(constant) then
		flow.add{
			type = "button",
			caption = "23",
			style = "gantry_constant_select_button"
		};
	else
		flow.add{
			type = "choose-elem-button",
			elem_type = "signal",
			style = "train_schedule_item_select_button",
		};
	end
	flow.add{
		type = "checkbox",
		state = constant,
	};
end

local add_circuit_condition_label = function(input_flow, constant)
	input_flow.add{
		type = "label",
		caption = {"gui.circuit-condition"},
		style = "squashable_label_with_left_padding",
	};
	input_flow.add{ -- This is just to shove the buttons to the right
		type = "flow",
		style = "relative_gui_top_flow"
	};
	local flow = input_flow.add{
		type = "flow",
		direction = "horizontal",
	};
	flow.add{
		type = "choose-elem-button",
		elem_type = "signal",
		style = "train_schedule_item_select_button",
	};
	flow.add{
		type = "drop-down",
		style = "circuit_condition_comparator_dropdown",
		items = {
			">",
			"<",
			"=",
			"≥",
			"≤",
			"≠"
		},
		selected_index = 2,
	};
	if(constant) then
		flow.add{
			type = "button",
			caption = "23",
			style = "gantry_constant_select_button"
		};
	else
		flow.add{
			type = "choose-elem-button",
			elem_type = "signal",
			style = "train_schedule_item_select_button",
		};
	end
	flow.add{
		type = "checkbox",
		state = constant,
	};
end

-- Takes in an LuaElementGUI as a root
--and builds and attaches the conditions
--gui to it as a child.
local add_condition_gui_to_element = function(root)
	local entity_frame = root.add{
		type = "frame",
		name = "conditions_outer_frame",
		style = "entity_frame",
		direction = "vertical",
	};

	local condition_title_frame = entity_frame.add{
		type = "frame",
		name = "invisible_frame",
		direction = "vertical",
		caption = {"gui.gantry-conditions"},
		style = "container_invisible_frame_with_title_without_left_padding",
	};

	local tabbed_pane = condition_title_frame.add{
		type = "frame",
		direction = "vertical",
		style = "gantry_window_content_in_pane",
	};

	local schedule_scroll_pane = tabbed_pane.add{
		type = "scroll-pane",
		horizontal_scroll_policy = "never",
		vertical_scroll_policy = "auto",
		style = "train_schedule_scroll_pane",--"gantry_condition_scroll_pane",
	};

	local fake_train_station = schedule_scroll_pane.add{
		type = "flow",
		direction = "vertical",
		style = "vertical_flow_horizontal_align_right",
	};

	add_condition(fake_train_station, add_time_passed_condition_label);
	add_condition(fake_train_station, add_inactivity_condition_label, "AND");
	add_condition(fake_train_station, add_full_cargo_condition_label, "OR");
	add_condition(fake_train_station, add_empty_cargo_condition_label, "OR");
	add_condition(fake_train_station, add_item_count_condition_label, "AND");
	add_condition(fake_train_station, add_circuit_condition_label, "OR");
	add_condition(fake_train_station, add_circuit_condition_label, "AND");
	add_condition(fake_train_station, add_circuit_condition_label, "AND");
	add_condition(fake_train_station, add_circuit_condition_label, "AND");
	add_condition(fake_train_station, add_circuit_condition_label, "AND");

	local text_button = fake_train_station.add{
		type = "button",
		caption = {"gui.add-condition"},
		style = "train_schedule_add_wait_condition_button",
	};
end

return add_condition_gui_to_element;
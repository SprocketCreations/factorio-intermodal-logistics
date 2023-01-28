
require("scripts.util.number-prettier");
--require();

local add_comparison_to_condition = function(condition_flow, isAnd, indent_amount)
	local indent_level = {
		"train_schedule_comparison_type_frame",
		"train_schedule_comparison_type_frame_indented",
		"train_schedule_comparison_type_frame_extra_indented",
	};
	local comparison_condition_frame = condition_flow.add {
		type = "frame",
		style = indent_level[indent_amount],
	};

	local sub_frame = comparison_condition_frame.add {
		type = "flow",
		direction = "horizontal",
	}

	local comparison_button = sub_frame.add {
		type = "button",
		name = "gantry_comparison_operator_button",
		caption = isAnd and { "gui.and" } or { "gui.or" },
		style = "train_schedule_comparison_type_button",
	};
end

local add_condition = function(fake_train_station_conditions_flow, condition_label_function, comparitor, indent,
                               condition)
	local condition_flow = fake_train_station_conditions_flow.add {
		type = "flow",
		direction = "horizontal",
	};

	if (comparitor and #(fake_train_station_conditions_flow.children) > 1) then
		add_comparison_to_condition(condition_flow, comparitor == "AND", indent);
	end

	local condition_frame = condition_flow.add {
		type = "frame",
		style = "train_schedule_condition_frame",
	};

	local input_flow = condition_frame.add {
		type = "flow",
		direction = "horizontal",
		style = "gantry_player_input_horizontal_flow",
	};

	condition_label_function(input_flow, condition);

	local reorder_controls_space = condition_frame.add {
		type = "flow",
		direction = "vertical",
		style = "gantry_reorder_vertical_flow",
	};

	local reorder_controls = reorder_controls_space.add {
		type = "flow",
		direction = "horizontal",
		style = "gantry_reorder_horizontal_flow",
	};

	reorder_controls.add {
		type = "sprite-button",
		name = "gantry_condition_up_button",
		style = "gantry_reorder_button",

		sprite = "up_arrow_sprite",
		hovered_sprite = "up_arrow_dark_sprite",
		clicked_sprite = "up_arrow_dark_sprite",
		mouse_button_filter = { "left" },
	};

	reorder_controls.add {
		type = "sprite-button",
		name = "gantry_condition_down_button",
		style = "gantry_reorder_button",

		sprite = "utility/collapse",
		hovered_sprite = "utility/collapse_dark",
		clicked_sprite = "utility/collapse_dark",
		mouse_button_filter = { "left" },
	};

	local condition_delete_button = condition_frame.add {
		type = "sprite-button",
		style = "train_schedule_delete_button",
		name = "gantry_condition_delete_button",

		sprite = "utility/close_white",
		hovered_sprite = "utility/close_black",
		clicked_sprite = "utility/close_black",
		mouse_button_filter = { "left" },
	};
end

local add_time_passed_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "textfield",
		name = "gantry_time_elapsed_customize_field",
		text = tostring(condition.time) .. " s",
		numeric = true;
		allow_decimal = true;
		lose_focus_on_confirm = true;
		style = "gantry_time_selection_textfield",
	}
	input_flow.add {
		type = "label",
		caption = { "gui.time-passed" },
		style = "squashable_label",
	};
end

local add_inactivity_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "textfield",
		name = "gantry_time_elapsed_customize_field",
		text = tostring(condition.time) .. " s",
		style = "gantry_time_selection_textfield",
		numeric = true;
		allow_decimal = true;
		lose_focus_on_confirm = true;
	}
	input_flow.add {
		type = "label",
		caption = { "gui.inactivity" },
		style = "squashable_label",
	};
end

local add_full_cargo_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "label",
		caption = { "gui.full-cargo" },
		style = "squashable_label_with_left_padding",
	};
end

local add_empty_cargo_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "label",
		caption = { "gui.empty-cargo" },
		style = "squashable_label_with_left_padding",
	};
end

local add_item_count_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "label",
		caption = { "gui.item-count" },
		style = "squashable_label_with_left_padding",
	};
	input_flow.add { -- This is just to shove the buttons to the right
		type = "flow",
		style = "relative_gui_top_flow",
	};
	local flow = input_flow.add {
		type = "flow",
		direction = "horizontal",
	};
	flow.add {
		type = "choose-elem-button",
		name = "gantry_choose_item_button_left",
		elem_type = "item",
		item = condition.left_item,
		style = "train_schedule_item_select_button",
	};
	flow.add {
		type = "drop-down",
		name = "gantry_comparison_operator_dropdown",
		style = "circuit_condition_comparator_dropdown",
		items = {
			">",
			"<",
			"=",
			"≥",
			"≤",
			"≠"
		},
		selected_index = condition.comparitor,
	};
	if (condition.use_constant) then
		flow.add {
			type = "textfield",
			name = "gantry_constant_textfield",
			text = prettify_number(condition.constant),
			numeric = true;
			allow_decimal = true;
			lose_focus_on_confirm = true;
			style = "gantry_constant_textfield"
		};
	else
		flow.add {
			type = "choose-elem-button",
			name = "gantry_choose_signal_button_right",
			elem_type = "signal",
			signal = condition.right_signal,
			style = "train_schedule_item_select_button",
		};
	end
	flow.add {
		type = "checkbox",
		name = "gantry_use_constant_checkbox",
		state = condition.use_constant,
	};
end

local add_circuit_condition_label = function(input_flow, condition)
	input_flow.add {
		type = "label",
		caption = { "gui.circuit-condition" },
		style = "squashable_label_with_left_padding",
	};
	input_flow.add { -- This is just to shove the buttons to the right
		type = "flow",
		style = "relative_gui_top_flow"
	};
	local flow = input_flow.add {
		type = "flow",
		direction = "horizontal",
	};
	flow.add {
		type = "choose-elem-button",
		name = "gantry_choose_signal_button_left",
		elem_type = "signal",
		signal = condition.left_signal,
		style = "train_schedule_item_select_button",
	};
	flow.add {
		type = "drop-down",
		name = "gantry_comparison_operator_dropdown",
		style = "circuit_condition_comparator_dropdown",
		items = {
			">",
			"<",
			"=",
			"≥",
			"≤",
			"≠"
		},
		selected_index = condition.comparitor,
	};
	if (condition.use_constant) then
		flow.add {
			type = "textfield",
			name = "gantry_constant_textfield",
			text = prettify_number(condition.constant),
			numeric = true;
			allow_decimal = true;
			lose_focus_on_confirm = true;
			style = "gantry_constant_textfield",
		};
	else
		flow.add {
			type = "choose-elem-button",
			name = "gantry_choose_signal_button_right",
			elem_type = "signal",
			signal = condition.right_signal,
			style = "train_schedule_item_select_button",
		};
	end
	flow.add {
		type = "checkbox",
		name = "gantry_use_constant_checkbox",
		state = condition.use_constant,
	};
end

-- Takes in an LuaElementGUI as a root
--and builds and attaches the conditions
--gui to it as a child.
function add_condition_gui_to_element(root)
	local entity_frame = root.add {
		type = "frame",
		name = "conditions_outer_frame",
		style = "entity_frame",
		direction = "vertical",
	};

	local condition_title_frame = entity_frame.add {
		type = "frame",
		name = "invisible_frame",
		direction = "vertical",
		caption = { "gui.gantry-conditions" },
		style = "container_invisible_frame_with_title_without_left_padding",
	};

	local tabbed_pane = condition_title_frame.add {
		type = "frame",
		name = "tabbed_pane",
		direction = "vertical",
		style = "gantry_window_content_in_pane",
	};

	local schedule_scroll_pane = tabbed_pane.add {
		type = "scroll-pane",
		name = "schedule_scroll_pane",
		horizontal_scroll_policy = "never",
		vertical_scroll_policy = "auto",
		style = "train_schedule_scroll_pane", --"gantry_condition_scroll_pane",
	};

	local fake_train_station = schedule_scroll_pane.add {
		type = "flow",
		name = "fake_train_station",
		direction = "vertical",
		style = "vertical_flow_horizontal_align_right",
	};

	local fake_train_station_conditions_flow = fake_train_station.add {
		type = "flow",
		name = "fake_train_station_conditions_flow",
		direction = "vertical",
		style = "vertical_flow_horizontal_align_right",
	};

	local text_button = fake_train_station.add {
		type = "drop-down",
		name = "gantry_condition_add_dropdown",
		style = "gantry_add_wait_condition_button",
		caption = { "gui.add-condition" },
		items = {
			"Inactivity",
			"Time passed",
			"Full cargo",
			"Empty cargo",
			"Item count",
			"Circuit condition",
		},


		--type = "button",
		--caption = {"gui.add-condition"},
		--style = "circuit_condition_comparator_dropdown",
	};
end

function add_condition_to_element(element, condition, comparator, indent)
	comparator = comparator or "OR";
	indent = indent or 1;
	local switch = {
		["time-elapsed"] = add_time_passed_condition_label;
		["inactivity"] = add_inactivity_condition_label;
		["full-cargo"] = add_full_cargo_condition_label;
		["empty-cargo"] = add_empty_cargo_condition_label;
		["item-count"] = add_item_count_condition_label;
		["circuit-condition"] = add_circuit_condition_label;
	};
	add_condition(element, switch[condition.type], comparator, indent, condition)
end

function regenerate_conditions(fake_train_station_conditions_flow, conditionals)
	local element = fake_train_station_conditions_flow;
	-- Remove all the condition boxes
	element.clear();

	local same_indent = conditional_do_all_operators_match(conditionals);
	local indent = same_indent and 1 or 2;

	local conditions = conditionals.conditions;
	if (#conditions > 0) then
		for i = 1, #conditions, 2 do
			local condition = conditions[i];
			local comparator = i == 1 and "OR" or conditions[i - 1];
			local element_indent = indent;
			if ((not same_indent) and comparator == "OR") then
				element_indent = element_indent + 1;
			end
			add_condition_to_element(element, condition, comparator, element_indent);
		end
	end

end


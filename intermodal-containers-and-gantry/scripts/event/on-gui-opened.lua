
require("scripts.gui.gantry-filters-gui");
require("scripts.gui.gantry-conditions-gui");

require("scripts.util.get-gui-stuff");
require("scripts.util.get-gantry-request-filters-gui");
require("scripts.util.get-gantry-conditions-flow");

function on_gui_opened(event)
	if (event.gui_type == defines.gui_type.entity) then
		-- Test if this is one of the socket entities
		if (true) then
			local player, socket, conditionals = get_gui_stuff(event.player_index);

			-- Gantry Filters
			local gantry_request_filters_gui = get_gantry_request_filters_gui(player);
			-- Remove all the buttons
			gantry_request_filters_gui.clear();
			-- Then re-add two rows
			add_filter_button_row(gantry_request_filters_gui, 2);
			for index, filter in pairs(socket.filters) do
				-- if we have run out of buttons
				if (index + 10 > #(gantry_request_filters_gui.children)) then
					-- Add more rows
					local rows_to_add = math.ceil((index + 10 - #(gantry_request_filters_gui.children)) / 10);
					add_filter_button_row(gantry_request_filters_gui, rows_to_add);
				end
				gantry_request_filters_gui.children[index].elem_value = filter;
			end
			-- Gantry Conditons
			local gantry_conditions_flow = get_gantry_conditions_flow(player);
			regenerate_conditions(gantry_conditions_flow, conditionals);

		end
	end
end

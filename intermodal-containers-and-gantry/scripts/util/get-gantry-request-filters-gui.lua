
local get_gantry_request_filters_gui = function(player)
	return player.gui.relative.socket_configuration.gantry_filters.invisible_frame.scroll_pane.logistic_background.gantry_request_filters;
end

return get_gantry_request_filters_gui;
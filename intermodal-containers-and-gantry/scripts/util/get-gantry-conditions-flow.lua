
local get_gantry_conditions_flow = function(player)
	return player.gui.relative.socket_configuration.conditions_outer_frame.invisible_frame.tabbed_pane.schedule_scroll_pane
		.fake_train_station.fake_train_station_conditions_flow;
end
return get_gantry_conditions_flow;

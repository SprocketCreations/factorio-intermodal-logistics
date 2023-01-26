require("scripts.gui.gantry-filters-gui");
require("scripts.gui.gantry-conditions-gui");

-- Removes the custom interface from the given LuaPlayer.
function remove_interface(player)
	local frame = player.gui.relative.socket_configuration;
	if (frame ~= nil) then
		frame.destroy();
	end
end

-- Constructs the custom interface for the given LuaPlayer.
function build_interface(player)
	local frame = player.gui.relative.add {
		type = "frame",
		name = "socket_configuration",
		direction = "vertical",
		visible = true,
		anchor =
		{
			gui = defines.relative_gui_type.container_gui,
			position = defines.relative_gui_position.right,
		},
		caption = "Gantry settings",
	};

	add_filter_gui_to_element(frame);
	add_condition_gui_to_element(frame);
end

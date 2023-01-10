local add_filter_gui = require("scripts.gui.gantry-filters-gui")[1];
local add_condition_gui = require("scripts.gui.gantry-conditions-gui");

-- Removes the custom interface from the given LuaPlayer.
local function remove_interface(player)
	local frame = player.gui.relative.socket_configuration;
	if (frame ~= nil) then
		frame.destroy();
	end
end

-- Constructs the custom interface for the given LuaPlayer.
local function build_interface(player)
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

	add_filter_gui(frame);
	add_condition_gui(frame);
end

return {remove_interface, build_interface};
-- This is the main control script.
-- It just sets all the event handlers
--to functions in other files.

local add_filter_gui = require("scripts.gui.gantry-filters-gui");
local add_condition_gui = require("scripts.gui.gantry-conditions-gui");

local function remove_interface(player)
	local frame = player.gui.relative.container_frame;
	if(frame ~= nil) then
		frame.destroy();
	end
end

local function build_interface(player)
	local frame = player.gui.relative.add{
		type = "frame",
		name = "container_frame",
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

commands.add_command("rebuild_gui", nil, function(command)
	local player = game.get_player(command.player_index);
	remove_interface(player);
	build_interface(player);
end);

script.on_configuration_changed(function (data)
	if(data.mod_changes["intermodal-containers-and-ganty"]) then
		for _, player in pairs(game.players) do
			remove_interface(player);
			build_interface(player);
		end
	end
end)

script.on_init(function()
	for _, player in pairs(game.players) do
		build_interface(player);
	end
end);

script.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index);
	build_interface(player);
end);
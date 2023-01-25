

local get_gui_stuff = function(player_index)
	local player = game.get_player(player_index);
	local socket = global.sockets[player.opened.unit_number];
	local conditions = socket.conditionals;
	return player, socket, conditions;
end

return get_gui_stuff;
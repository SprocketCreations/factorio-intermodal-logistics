
-- Globals init function.
-- This will leave existing tables intact.
function init_globals()
	if(global.gantry_clusters == nil) then
		-- Array containing every gantry cluster
		global.gantry_clusters = {};
	end

	if(global.gantries == nil) then
		-- Map containing every gantry entity mapped to its lua data
		global.gantries = {};
	end

	if(global.sockets == nil) then
		-- Map containing every socket entity mapped to its lua data
		global.sockets = {};
	end
end

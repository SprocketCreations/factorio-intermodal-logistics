-- Globals init function.
-- This will leave existing tables intact.
-- These are for the ingame global object
function init_static_globals()
	if (global.gantry_clusters == nil) then
		-- Array containing every gantry cluster
		global.gantry_clusters = {};
	end

	if (global.gantry_controllers == nil) then
		-- Map containing every gantry entity mapped to its lua data
		global.gantry_controllers = {};
	end

	if (global.sockets == nil) then
		-- Map containing every socket entity mapped to its lua data
		global.sockets = {};
	end
end

-- These are more generic non serialized globals
function init_transient_globals()
	--TODO:
end

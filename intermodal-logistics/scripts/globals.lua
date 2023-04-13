-- Globals init function.
-- This will leave existing tables intact.
-- These are for the ingame global object
function init_static_globals()
	if (global.gantry_clusters == nil) then
		---@type GantryCluster[] Array containing every gantry cluster
		global.gantry_clusters = {};
	end

	if (global.gantry_controllers == nil) then
		---@type {[number]: GantryController} Map containing every gantry entity mapped to its lua data
		global.gantry_controllers = {};
	end

	if (global.sockets == nil) then
		---@type {[number]: ContainerSocket} Map containing every socket entity mapped to its lua data
		global.sockets = {};
	end
end

-- These are more generic non serialized globals
function init_transient_globals()
	-- There are none so far.
	-- Maybe I'll need some later.
	-- That's what this function is for.
end

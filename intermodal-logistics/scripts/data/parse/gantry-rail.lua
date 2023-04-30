require("scripts.prototypes.gantry-rail-prototype");

---Parse and package a gantry rail prototype.
---@param gantry_rail table The raw prototype provided to the mod.
function parse_gantry_rail(gantry_rail)
	local gantry_rail_prototype = make_gantry_rail_prototype(
		gantry_rail.type,
		gantry_rail.name);

	intermodal_logistics_pipeline:add_gantry_rail_prototype(gantry_rail_prototype);
end

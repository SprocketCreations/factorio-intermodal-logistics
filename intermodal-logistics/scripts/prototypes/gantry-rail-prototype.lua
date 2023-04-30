---@class GantryRailPrototype: CustomPrototype
---@field

---Constructor for a GantryRailPrototype
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return GantryRailPrototype # The new rail prototype.
function make_gantry_rail_prototype(type, name)
	local super = make_custom_prototype(type, name);

	---@cast super GantryRailPrototype

	return super;
end

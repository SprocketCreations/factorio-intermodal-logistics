---@class RailPrototype: CustomPrototype

---Constructor for a 'RailPrototype'
---@param name string The name of this prototype.
---@return RailPrototype # The new rail prototype.
function make_rail_prototype(name)
	assert_type(name, 'string', "name must be a string.");

	return {
		name = name,
	};
end
---@class CustomPrototype
---@field type string The type of the prototype.
---@field name string The name of the prototype.

---Creates a new instance of the CustomPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return CustomPrototype # the new custom prototype.
function make_custom_prototype(type, name)
	--Type has already been verified by this point.
	--assert_type(type, 'string', "type must be a string.");
	assert_type(name, 'string', "name must be a string.");

	return {
		type = type,
		name = name,
	};
end

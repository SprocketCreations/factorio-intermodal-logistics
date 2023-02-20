---@class ContainerPrototype: CustomPrototype
---@field animation_name string The name of the sprite animation prototype.
---@field inventory_size number The number of slots in this container's inventory.
---@field length number The number of 'slots' this container needs.
---@field vertical_offset number The offset that needs to be applied to this container to get it on the ground.

---Constructor for a 'ContainerPrototype'
---@param name string The name of this prototype.
---@param animation_name string The name of the sprite animation prototype.
---@param inventory_size number The number of slots in this container's inventory.
---@param length number The number of 'slots' this container needs.
---@param vertical_offset number? The offset that needs to be applied to this container to get it on the ground. Default 0.
---@return ContainerPrototype # The new container prototype.
function make_container_prototype(name, animation_name, inventory_size, length, vertical_offset)
	assert_type(name, 'string', "name must be a string.");
	assert_type(animation_name, 'string', "animation_name must be a string.");
	assert_type(inventory_size, 'number', "inventory_size must be a number.");
	assert_type(length, 'number', "length must be a number.");
	if(vertical_offset) then assert_type(vertical_offset, 'number', "vertical_offset must be a number."); end
	
	return {
		name = name,
		animation_name = animation_name,
		inventory_size = inventory_size,
		length = length,
		vertical_offset = vertical_offset or 0,
	};
end

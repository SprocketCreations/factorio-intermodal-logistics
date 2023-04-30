require("scripts.prototypes.custom-prototype");

---@class ContainerPrototype: CustomPrototype
---@field animation_name string The name of the sprite animation prototype.
---@field inventory_size number The number of slots in this container's inventory.
---@field vertical_offset number The offset that needs to be applied to this container to get it on the ground.

---Constructor for a ContainerPrototype
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@param animation_name string The name of the sprite animation prototype.
---@param inventory_size number The number of slots in this container's inventory.
---@param vertical_offset number? The offset that needs to be applied to this container to get it on the ground. Default 0.
---@return ContainerPrototype # The new container prototype.
function make_container_prototype(type, name, animation_name, inventory_size, vertical_offset)
	assert_type(animation_name, 'string', "animation_name must be a string.");
	assert_type(inventory_size, 'number', "inventory_size must be a number.");
	if (vertical_offset) then assert_type(vertical_offset, 'number', "vertical_offset must be a number."); end

	local super = make_custom_prototype(type, name);

	---@cast super ContainerPrototype

	super.animation_name = animation_name;
	super.inventory_size = inventory_size;
	super.vertical_offset = vertical_offset or 0;

	return super;
end

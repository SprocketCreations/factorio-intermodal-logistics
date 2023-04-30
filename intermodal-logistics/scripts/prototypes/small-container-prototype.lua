require("scripts.prototypes.container-prototype");

---@class SmallContainerPrototype: ContainerPrototype
---@field

---Constructor for a SmallContainerPrototype
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@param animation_name string The name of the sprite animation prototype.
---@param inventory_size number The number of slots in this container's inventory.
---@param vertical_offset number? The offset that needs to be applied to this container to get it on the ground. Default 0.
---@return SmallContainerPrototype # The new container prototype.
function make_small_container_prototype(type, name, animation_name, inventory_size, vertical_offset)
	local super = make_container_prototype(type, name, animation_name, inventory_size, vertical_offset);
	---@cast super SmallContainerPrototype

	return super;
end

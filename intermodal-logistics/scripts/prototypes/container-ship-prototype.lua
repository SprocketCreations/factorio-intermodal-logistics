require("scripts.prototypes.custom-prototype");

---@class ContainerShipPrototype: CustomPrototype

---Constructor for the ContainerShipPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return ContainerShipPrototype # The new container ship.
function make_container_ship(type, name)
	local super = make_custom_prototype(type, name);

	---@cast super ContainerShipPrototype

	return super;
end

require("scripts.prototypes.custom-prototype");

---@class ContainerWagonPrototype: CustomPrototype

---Constructor for the ContainerWagonPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return ContainerWagonPrototype # The new container wagon.
function make_container_wagon(type, name)
	local super = make_custom_prototype(type, name);
	---@cast super ContainerWagonPrototype

	return super;
end

require("scripts.prototypes.custom-prototype");

---@class ContainerDockPrototype: CustomPrototype
---@field

---Constructor for the ContainerDockPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return ContainerDockPrototype # The new dock.
function make_container_dock(type, name)
	local super = make_custom_prototype(type, name);
	---@cast super ContainerDockPrototype

	return super;
end

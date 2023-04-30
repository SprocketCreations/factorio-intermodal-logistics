require("scripts.prototypes.container-dock-prototype");

---@class SmallContainerDockPrototype: ContainerDockPrototype
---@field

---Constructor for the SmallContainerDockPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return SmallContainerDockPrototype # The new small dock.
function make_small_container_dock(type, name)
	local super = make_container_dock(type, name);

	---@cast super SmallContainerDockPrototype

	return super;
end

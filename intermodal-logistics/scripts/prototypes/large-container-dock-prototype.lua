require("scripts.prototypes.container-dock-prototype");

---@class LargeContainerDockPrototype: ContainerDockPrototype
---@field

---Constructor for the LargeContainerDockPrototype class.
---@param type string The type of the prototype.
---@param name string The name of the prototype.
---@return LargeContainerDockPrototype # The new large dock.
function make_large_container_dock(type, name)
	local super = make_container_dock(type, name);

	---@cast super LargeContainerDockPrototype

	return super;
end

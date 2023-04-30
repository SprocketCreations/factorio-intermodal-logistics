require("scripts.data.creation-helpers.create-large-container-animation");
require("scripts.prototypes.large-container-prototype");

---Parse and package a large container prototype.
---@param container table The raw prototype table provided to the mod.
function parse_large_container(container)
	---TODO: Do some assertions


	local animation_prototype = create_large_container_animation(container);

	local container_prototype =
		make_large_container_prototype(
			"large-container",
			container.name,
			animation_prototype,
			container.inventory_size,
			container.vertical_offset);

	intermodal_logistics_pipeline:add_large_container_prototype(container_prototype);
end

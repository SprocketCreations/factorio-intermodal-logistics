require("scripts.data.verify.verify-container");
require("scripts.data.creation-helpers.create-container-animation");

---Parse and package all the gantry prototypes.
---@param raw_container table The unqualified table provided to the mod.
function parse_container(raw_container)
	local data = verify_raw_container(raw_container);

	local container = data.container;

	local animation_prototype = create_container_animation(container);

	local container_prototype =
		make_container_prototype(
			container.name,
			animation_prototype,
			container.inventory_size,
			container.length,
			container.vertical_offset);

	intermodal_logistics_pipeline:add_container_prototype(container_prototype);
end

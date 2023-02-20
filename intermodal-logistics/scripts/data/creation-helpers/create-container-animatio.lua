require("scripts.util.assert");
---Creates a sprite animation according to the input data.
---@param container_data table The table of all the information needed to construct a sprite animation.
---@return string # The name of the sprite animation prototype.
function create_container_animation(container_data)
	assert(type(container_data) == 'table', "container_data must be a table.");
	assert(type(container_data.name) == 'string', "container_data.name must be a string.");
	assert(type(container_data.pictures) == 'table', "container_data.pictures must be a table.");

	local prototype_name = container_data.name .. "-animation";
	local layers =
		container_data.pictures.layers or
		{ container_data.pictures };

	local animation = {
		name = prototype_name,
		type = "animation",
		layers = layers,
	};
	data:extend { animation };
	return prototype_name;
end

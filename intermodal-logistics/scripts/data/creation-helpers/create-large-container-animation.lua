require("scripts.util.assert");
---Creates a sprite animation according to the input data.
---@param container_data table The table of all the information needed to construct a sprite animation.
---@return string # The name of the sprite animation prototype.
function create_large_container_animation(container_data)
	assert_type(container_data, 'table', "container_data must be a table");
	assert_type(container_data.name, 'string', "name must be a string");

	local prototype_name = container_data.name .. "-animation";
	local layers = {};

	local make_stripes = function(layer)
		local width_in_frames = layer.line_length;
		local height_in_frames = layer.lines_per_file or 0;
		local x = 0;
		local y = 0;

		local stripes = {};
		for _, filename in ipairs(layer.filenames) do
			table.insert(stripes, {
				width_in_frames = width_in_frames,
				height_in_frames = height_in_frames,
				filename = filename,
				x = x,
				y = y,
			});
		end
		return stripes;
	end

	local add_layer = function(layer)
		table.insert(layers, {
			hr_version = nil,
			priority = "medium",
			flags = {},
			size = layer.size,
			width = layer.width,
			height = layer.height,
			x = layer.x,
			y = layer.y,
			position = layer.position,
			shift = layer.shift,
			draw_as_shadow = layer.draw_as_shadow,
			draw_as_glow = layer.draw_as_glow,
			draw_as_light = layer.draw_as_light,
			mipmap_count = layer.mipmap_count,
			apply_runtime_tint = layer.apply_runtime_tint,
			tint = layer.tint,
			blend_mode = layer.blend_mode,
			premul_alpha = layer.premul_alpha,
			run_mode = "forward",
			frame_count = layer.direction_count,
			stripes = make_stripes(layer),
		});
	end

	if (container_data.layers) then
		assert_type(container_data.layers, 'table', "layers must be a table");
		for _, layer in ipairs(container_data.layers) do
			add_layer(layer);
		end
	elseif (container_data.pictures) then
		assert_type(container_data.pictures, 'table', "pictures must be a table");
		add_layer(container_data.pictures);
	else
		error("layers or pictures must exist");
	end

	local animation = {
		name = prototype_name,
		type = "animation",
		layers = layers,
	};
	data:extend { animation };
	return prototype_name;
end


-- Creates an object to manage the different related prototypes of a gantry entity
local make_gantry_prototype_object = function(settings_array)
	for _, settings in pairs(settings_array) do
		local object = {};

		object.placement_dummy_prototype_name = settings.placement_dummy_prototype_name;
		object.vertical_prototype_name = settings.vertical_prototype_name;
		object.horizontal_prototype_name = settings.horizontal_prototype_name;

		table.insert(gantry_prototype.gantry_prototypes, object);
	end
end

return make_gantry_prototype_object;
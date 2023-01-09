-- Creates an object to manage the different related prototypes of a cradle entity
local make_cradle_prototype_object = function(settings_array)
	for _, settings in pairs(settings_array) do
		local object = {};

		object.type = "cradle";

		object.placement_dummy_prototype_name = settings.placement_dummy_prototype_name;
		object.empty_vertical_prototype_name = settings.empty_vertical_prototype_name;
		object.empty_horizontal_prototype_name = settings.empty_horizontal_prototype_name;
		object.containered_vertical_prototype_name = settings.containered_vertical_prototype_name;
		object.containered_horizontal_prototype_name = settings.containered_horizontal_prototype_name;

		table.insert(gantry_prototype.cradle_prototypes, object);

		--this feels cursed
		gantry_prototype.socket_prototypes[object.placement_dummy_prototype_name] = object;
		gantry_prototype.socket_prototypes[object.empty_vertical_prototype_name] = object;
		gantry_prototype.socket_prototypes[object.empty_horizontal_prototype_name] = object;
		gantry_prototype.socket_prototypes[object.containered_vertical_prototype_name] = object;
		gantry_prototype.socket_prototypes[object.containered_horizontal_prototype_name] = object;
	end
end

return make_cradle_prototype_object;
-- Creates an object to manage the different related prototypes of a flatbed wagon entity
function make_flatbed_prototype_object(settings_array)
	for _, settings in pairs(settings_array) do
		local object = {};

		object.empty_prototype_name = settings.empty_prototype_name;
		object.containered_prototype_name = settings.containered_prototype_name;

		table.insert(gantry_prototype.flatbed_prototypes, object);
	end
end

return make_flatbed_prototype_object;
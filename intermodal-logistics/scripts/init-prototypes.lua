
-- Uses the remote interface tool to register the prototypes to the system.
-- If this function is called more than once without first clearing the globals
--tables, it will insert duplicate elements. This may not be a problem.
function init_prototypes()
	--[[ GANTRY REGISTRY ]]
	remote.call("register_prototypes", "register_gantry", {
		{
			placement_dummy_prototype_name = "",
			vertical_prototype_name = "",
			horizontal_prototype_name = "",
		},
	});

	--[[ CRADLE REGISTRY ]]
	remote.call("register_prototypes", "register_cradle", {
		{
			placement_dummy_prototype_name = "cradle-dummy",
			empty_vertical_prototype_name = "vertical-empty-cradle",
			empty_horizontal_prototype_name = "horizontal-empty-cradle",
			containered_vertical_prototype_name = "vertical-intermodal-cradle",
			containered_horizontal_prototype_name = "horizontal-intermodal-cradle",
		},
	});

	--[[ FLATBED REGISTRY ]]
	remote.call("register_prototypes", "register_flatbed", {
		{
			empty_prototype_name = "flatbed-wagon",
			containered_prototype_name = "intermodal-flatbed-wagon",
		},
	});
end
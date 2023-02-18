
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

	--[[ dock REGISTRY ]]
	remote.call("register_prototypes", "register_dock", {
		{
			placement_dummy_prototype_name = "dock-dummy",
			empty_vertical_prototype_name = "vertical-empty-dock",
			empty_horizontal_prototype_name = "horizontal-empty-dock",
			containered_vertical_prototype_name = "vertical-intermodal-dock",
			containered_horizontal_prototype_name = "horizontal-intermodal-dock",
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

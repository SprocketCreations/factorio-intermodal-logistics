local init_prototypes = require("scripts.init-prototypes");

local function init_prototype_globals()
	gantry_prototype = {
		socket_prototypes = {},
		gantry_prototypes = {},
		cradle_prototypes = {},
		flatbed_prototypes = {},
	};
	init_prototypes();
end

return init_prototype_globals;
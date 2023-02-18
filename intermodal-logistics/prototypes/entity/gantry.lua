local bogey_north_picture = {
	filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/bogey-north.png";
	size = { 352, 164 };
	scale = 1;
	shift = { 0.0, -2.277687221765518 };
};
local bogey_east_picture = {
	filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/bogey-east.png";
	size = { 64, 368 };
	scale = 1;
	shift = { 0.0, -2.0007780268788338 };
};


-- The bogey being used
-- This is a simple entity.
local bogey = {
	picture = {
		north = bogey_north_picture;
		east = bogey_east_picture;
		south = bogey_north_picture;
		west = bogey_east_picture;
	};
	type = 'bogey';
	-- The bogey's collider
	collision_box = { { -4.8, -0.3 }, { 4.8, 0.3 } };
	drawing_box = { { -4, -0.5 }, { 4, 0.5 } };
};

local small_gantry = {
	-- Type can be "gantry" or "crane"
	type = "gantry",
	-- Name to use to refer to the entity prototype
	name = "small-gantry",
	-- Icons
	icon = "__intermodal-logistics__/graphics/icon/small-gantry.png";
	icon_size = 64;

	-- specify how far the trolly can move. minimum and maximum
	work_width = { -3, 6 };

	flags = {
		"placeable-neutral",
		"player-creation",
		"no-automated-item-removal",
		"no-automated-item-insertion",
	};
	-- Used to specify information that can change given various rotations.
	-- north and east are required
	-- south defaults to north
	-- west defaults to east
	rotations = {
		-- If south is not specified, north will be used.
		north = {
			-- Array of ground contact bogeys.
			bogeys = {
				{
					bogey = bogey;
					-- Table for how the bogeys are positioned relative to the gantry
					positions = { { 0, -4.5 }, { 0, 4.5 } };
				},
			};
			--use to specify how the player can select the gantry to mine it.
			selection_box = { { -4, -5 }, { 4, 7 } };
			-- use to specify this rotation's drawing_box.
			drawing_box = { { -4, -5 }, { 4, 7 } };

			-- All the pictures to be used with the rotations
			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/north.png";
				size = { 320, 512 };
				scale = 1;
				shift = { 0.0, -6.647111415863037 };
			};
		};
		-- If west is not specified, east will be used.
		east = {
			bogeys = {
				{
					bogey = bogey;
					positions = { { -4.5, 0 }, { 4.5, 0 } };
				},
			};
			selection_box = { { -5, -4 }, { 7, 4 } };
			drawing_box = { { -5, -4 }, { 7, 4 } };
			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/east.png";
				size = { 672, 280 };
				scale = 1;
				shift = { 2.2977801337838173, -4.611127525568008 };
			}
		};
		south = {
			-- Array of bogeys.
			bogeys = {
				{
					bogey = bogey;
					-- Table for how the bogies are positioned relative to the gantry
					positions = { { 0, -4.5 }, { 0, 4.5 } };
				},
			};
			selection_box = { { -4, -5 }, { 4, 7 } };
			drawing_box = { { -4, -5 }, { 4, 7 } };

			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/south.png";
				size = { 320, 512 };
				scale = 1;
				shift = { 0.0, -3.3590643405914307 };
			};
		};
		west = {
			bogies = {
				{
					bogey = bogey;
					positions = { { -4.5, 0 }, { 4.5, 0 } };
				},
			};
			selection_box = { { -5, -4 }, { 7, 4 } };
			drawing_box = { { -5, -4 }, { 7, 4 } };
			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/west.png";
				size = { 672, 280 };
				scale = 1;
				shift = { -2.2977816984057426, -4.611127525568008 };
			};
		};
	};
}

intermodal_logistics_data:extend { small_gantry };

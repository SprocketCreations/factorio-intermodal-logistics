local gantry =
{
	-- Simple entity with owner
	picture = { sheet = {
		filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry.png";
		frames = 4;
		size = { 416, 320 };
		scale = 2;
		shift = { 0, -5 };
	} };
	-- Entity
	icon = "__intermodal-logistics__/graphics/icon/small-gantry.png";
	icon_size = 64;


	collision_box = { { -4.8, -4.8 }, { 4.8, 4.8 } };
	selection_box = { { -4, -4 }, { 4, 4 } };

	drawing_box = { { -13, -13 }, { 13, 13 } };

	flags = {
		"placeable-neutral",
		"player-creation",
		"no-automated-item-removal",
		"no-automated-item-insertion",
	};

	-- Base
	name = "small-gantry";
	type = "simple-entity-with-owner";
};
data:extend({ gantry });

-- The truck being used
-- This is a simple entity.
local truck = {
	picture = {
		sheet = {
			filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/truck.png";
			frames = 4;
			size = { 200, 200 };
			scale = 1;
			shift = { 0, 0 };
		}
	};
	type = 'truck';
	-- The truck's collider
	collision_box = { { -3.8, -0.3 }, { 3.8, 0.3 } };
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
			-- Array of ground contact trucks.
			ground_trucks = {
				{
					truck = truck;
					-- Table for how the trucks are positioned relative to the gantry
					positions = {
						{ 0, -4 },
						{ 0, 4 }
					};
				},
			};
			-- specify how far the trolly can move. minimum and maximum
			work_width = { -3, 6 };
			--use to specify how the player can select the gantry to mine it.
			selection_box = { { -4, -5 }, { 4, 7 } };
			-- use to specify this rotation's drawing_box.
			drawing_box = { { -4, -5 }, { 4, 7 } };

			-- All the pictures to be used with the rotations
			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/north.png";
				size = { 416, 320 };
				scale = 2;
				shift = { 0, -5 };
			};
		};
		-- If west is not specified, east will be used.
		east = {
			ground_trucks = {
				{
					collision_box = { { -4, -0.5 }, { 4, 0.5 } };
					positions = { { 0, -4 }, { 0, 4 } };
				},
			};
			work_width = { -3, -6 };
			selection_box = { { -5, -4 }, { 7, 4 } };
			drawing_box = { { -5, -4 }, { 7, 4 } };
			pictures = {
				filename = "__intermodal-logistics__/graphics/entity/gantry/small-gantry/east.png";
				size = { 416, 320 };
				scale = 2;
				shift = { 0, -5 };
			}
		};
	};
}

intermodal_logistics:extend { small_gantry };

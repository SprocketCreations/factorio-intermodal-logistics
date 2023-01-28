local gantry =
{
	-- Simple entity with owner
	picture = { sheet = {
		filename = "__intermodal-containers-and-gantry__/graphics/entity/gantry/small-gantry.png";
		frames = 4;
		size = { 416, 320 };
		scale = 2;
		shift = { 0, -5 };
	} };
	-- Entity
	icon = "__intermodal-containers-and-gantry__/graphics/icon/small-gantry.png";
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



local small_gantry = {
	-- Type can be "gantry" or "crane"
	type = "gantry",
	-- Name to use to refer to the entity prototype
	name = "small-gantry",
	-- Icons
	icon = "__intermodal-containers-and-gantry__/graphics/icon/small-gantry.png";
	icon_size = 64;

	flags = {
		"placeable-neutral",
		"player-creation",
		"no-automated-item-removal",
		"no-automated-item-insertion",
	};

	-- Array of ground contacts.
	end_trucks = {
		{
			-- The truck's collider
			collision_box = { { -4, -0.5 }, { 4, 0.5 } };
			selection_box = { { -3.8, -0.3 }, { 3.8, 0.3 } };
			-- Table for how the trucks are positioned relative to the gantry
			positions = {
				-- Array of all the positions this truck appears in on this gantry
				north = { { 0, -4 }, { 0, 4 } };
				south = { { 0, 4 }, { 0, -4 } };
				east = { { -4, 0 }, { 4, 0 } };
				west = { { 4, 0 }, { -4, 0 } };
			};
		},
	};

	-- All the pictures to be used with the rotations
	pictures = {
		north = {
			filename = "";
			-- Custom field for this rotation's drawing box
			drawing_box = {};
		};
	}
}

gantry:extend({ small_gantry });

require("scripts.util.stringify");

---Packages the intermodal logistics game data so that it can be preserved to the control stage.
---@param intermodal_logistics_game IntermodalLogisticsGame
function send_game_to_pipeline(intermodal_logistics_game)
	local jsnot = stringify_table(intermodal_logistics_game);

	local mutilated_data = {};

	local first = 1;
	local last = 200;
	local number_of_characters = #jsnot;

	if (number_of_characters > 8000) then
		error("You ran out of characters nerd. Limit 8000, used " .. tostring(number_of_characters));
	end

	while first <= number_of_characters do
		table.insert(mutilated_data, string.sub(jsnot, first, math.min(last, number_of_characters)));
		first = first + 200;
		last = last + 200;
	end

	data:extend { {
		-- Can get 8000 characters via these two string arrays
		-- Table limited to 20 entries.
		localised_description = { table.unpack(mutilated_data, 1, 200) },
		-- Table limited to 20 entries.
		localised_name = #mutilated_data < 201 and { "" } or { table.unpack(mutilated_data, 201, 400) },
		name = "gantry-data-control-pipeline",
		type = "recipe-category",
		--group = "gantry-group";
	} };
end

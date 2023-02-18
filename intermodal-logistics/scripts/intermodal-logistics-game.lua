require("scripts.util.parse-table");

---@class IntermodalLogisticsGame
---@field gantries GantryPrototype[]
---@field docks DockPrototype[]
---@field container_wagons ContainerWagonPrototype[]
---@field container_ships ContainerShipPrototype[]

---@return string # The reconstructed jsnot from the data stage.
local function get_jsnot()
	local pipeline = game.recipe_category_prototypes["gantry-data-control-pipeline"];
	---@type string[]
	local jsnot_builder = {};
	for i = 1, #(pipeline.localised_description), 1 do
		table.insert(jsnot_builder, pipeline.localised_description[i]);
	end
	if (type(pipeline.localised_name) == "table") then
		for i = 1, #(pipeline.localised_name), 1 do
			table.insert(jsnot_builder, pipeline.localised_name[i]);
		end
	end
	---@type string
	return table.concat(jsnot_builder);
end

---Adds the "type" field to all the prototypes, with a value of the prototype
local function add_type_to_all_prototypes()
	for _, gantry in pairs(intermodal_logistics_game.gantries) do
		gantry.type = "gantry";
	end
	for _, dock in pairs(intermodal_logistics_game.docks) do
		dock.type = "dock";
	end
	for _, container_wagon in pairs(intermodal_logistics_game.container_wagons) do
		container_wagon.type = "container-wagon";
	end
	for _, container_ship in pairs(intermodal_logistics_game.container_ships) do
		container_ship.type = "container-ship";
	end
end


function parse_data_pipeline()
	---@type IntermodalLogisticsGame
	intermodal_logistics_game = parse_table(get_jsnot());
	add_type_to_all_prototypes();

	function intermodal_logistics_game:get_data(prototype)
		return self.gantries[prototype] or
			self.docks[prototype] or
			self.flatbeds[prototype];
	end
end

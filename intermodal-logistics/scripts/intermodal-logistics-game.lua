require("scripts.util.parse-table");
require("util");

---@class IntermodalLogisticsGame
---Properties:
---@field gantries GantryPrototype[]
---@field gantry_rails GantryRailPrototype[]
---@field small_containers SmallContainerPrototype[]
---@field large_containers LargeContainerPrototype[]
---@field small_container_docks SmallContainerDockPrototype[]
---@field large_container_docks LargeContainerDockPrototype[]
---@field container_wagons ContainerWagonPrototype[]
---@field container_ships ContainerShipPrototype[]
---Lookup tables:
---@field prototype_map {[string]: CustomPrototype}
---@field associated_prototype_map {[string]: CustomPrototype}
---@field gantry_rail_prototype_names string[]
---Methods:
---@field get_prototype_by_name fun(self: IntermodalLogisticsGame, prototype_name: string): CustomPrototype Gets a prototype's data given its name.
---@field get_prototype_by_associated_prototype fun(self: IntermodalLogisticsGame, prototype_name: string): CustomPrototype Gets a prototype's data given its accociated vanilla prototype name.
---@field get_gantry_rail_prototypes fun(self: IntermodalLogisticsGame): string[] Returns an array of rail prototype names. Meant for use with LuaSurface.find_entities_filtered.

---Constructor for an IntermodalLogisticsGame.
---@param intermodal_logistics_pipeline IntermodalLogisticsPipeline The pipeline data.
---@return IntermodalLogisticsGame # The constructed mod game script.
function make_intermodal_logistics_game(intermodal_logistics_pipeline)
	---@type IntermodalLogisticsGame
	local intermodal_logistics_game = {
		-- Arrays.
		gantry_rails = util.table.deepcopy(intermodal_logistics_pipeline.gantry_rails),
		gantries = util.table.deepcopy(intermodal_logistics_pipeline.gantries),
		small_containers = util.table.deepcopy(intermodal_logistics_pipeline.small_containers),
		small_container_docks = util.table.deepcopy(intermodal_logistics_pipeline.small_container_docks),
		large_containers = util.table.deepcopy(intermodal_logistics_pipeline.large_containers),
		large_container_docks = util.table.deepcopy(intermodal_logistics_pipeline.large_container_docks),
		container_wagons = util.table.deepcopy(intermodal_logistics_pipeline.container_wagons),
		container_ships = util.table.deepcopy(intermodal_logistics_pipeline.container_ships),
		-- Lookup tables.
		prototype_map = {},
		associated_prototype_map = {},
		gantry_rail_prototype_names = {},
	};

	for _, gantry_rail in ipairs(intermodal_logistics_game.gantry_rails) do
		gantry_rail.type = "gantry-gantry";
		table.insert(intermodal_logistics_game.gantry_rail_prototype_names, gantry_rail.name);
	end
	for _, gantry in ipairs(intermodal_logistics_game.gantries) do
		gantry.type = "gantry";
		intermodal_logistics_game.prototype_map[gantry.name] = gantry;

		--Dummy
		intermodal_logistics_game.associated_prototype_map[gantry.placement_dummy_prototype] = gantry;
		--Rotations
		intermodal_logistics_game.associated_prototype_map[gantry.rotations.north.prototype] = gantry;
		intermodal_logistics_game.associated_prototype_map[gantry.rotations.east.prototype] = gantry;
		intermodal_logistics_game.associated_prototype_map[gantry.rotations.south.prototype] = gantry;
		intermodal_logistics_game.associated_prototype_map[gantry.rotations.west.prototype] = gantry;
		--Bogies
		local all_bogies = {
			table.unpack(gantry.rotations.north.bogies),
			table.unpack(gantry.rotations.east.bogies),
			table.unpack(gantry.rotations.south.bogies),
			table.unpack(gantry.rotations.west.bogies) };
		for _, bogey in ipairs(all_bogies) do
			intermodal_logistics_game.associated_prototype_map[bogey.prototype] = gantry;
		end
	end
	for _, small_container_dock in ipairs(intermodal_logistics_game.small_container_docks) do
		-- dock.type = "dock";
		-- intermodal_logistics_game.prototype_map[dock.name] = dock;
		-- -- associations
		-- intermodal_logistics_game.associated_prototype_map[dock.placement_dummy_prototype] = dock;
	end
	for _, small_container in ipairs(intermodal_logistics_game.small_containers) do
		small_container.type = "small-container";
		intermodal_logistics_game.prototype_map[small_container.name] = small_container;
	end
	for _, large_container_dock in ipairs(intermodal_logistics_game.large_container_docks) do
		-- dock.type = "dock";
		-- intermodal_logistics_game.prototype_map[dock.name] = dock;
		-- -- associations
		-- intermodal_logistics_game.associated_prototype_map[dock.placement_dummy_prototype] = dock;
	end
	for _, large_container in ipairs(intermodal_logistics_game.large_containers) do
		large_container.type = "large-container";
		intermodal_logistics_game.prototype_map[large_container.name] = large_container;
	end
	for _, container_wagon in ipairs(intermodal_logistics_game.container_wagons) do
		container_wagon.type = "container-wagon";
		intermodal_logistics_game.prototype_map[container_wagon.name] = container_wagon;
	end
	for _, container_ship in ipairs(intermodal_logistics_game.container_ships) do
		container_ship.type = "container-ship";
		intermodal_logistics_game.prototype_map[container_ship.name] = container_ship;
	end

	---Gets a prototype's data given its name.
	---@param prototype_name string The name.
	---@return CustomPrototype # The prototype.
	function intermodal_logistics_game:get_prototype_by_name(prototype_name)
		return self.prototype_map[prototype_name];
	end

	---Gets a prototype's data given its accociated vanilla prototype name.
	---@param prototype_name string The accociated prototype's name.
	---@return CustomPrototype # The prototype.
	function intermodal_logistics_game:get_prototype_by_associated_prototype(prototype_name)
		return self.associated_prototype_map[prototype_name];
	end

	---Returns an array of rail prototype names. Meant for use with LuaSurface.find_entities_filtered.
	---@return string[] # Prototype names.
	function intermodal_logistics_game:get_gantry_rail_prototypes()
		return self.gantry_rail_prototype_names;
	end

	return intermodal_logistics_game;
end

---@return string # The reconstructed dump from the data stage.
local function get_dump()
	local pipeline = game.recipe_category_prototypes["intermodal-logistics-data-control-pipeline-0"];
	---@type string[]
	local dump = {};
	for i = 1, #(pipeline.localised_description), 1 do
		table.insert(dump, pipeline.localised_description[i]);
	end
	if (type(pipeline.localised_name) == "table") then
		for i = 1, #(pipeline.localised_name), 1 do
			table.insert(dump, pipeline.localised_name[i]);
		end
	end
	---@type string
	return table.concat(dump);
end


function parse_data_pipeline()
	local ok, res = serpent.load(get_dump());
	if (ok) then
		---@type IntermodalLogisticsGame
		intermodal_logistics_game = make_intermodal_logistics_game(res);
	else
		error("Failure parsing data pipeline: " .. res);
	end
end

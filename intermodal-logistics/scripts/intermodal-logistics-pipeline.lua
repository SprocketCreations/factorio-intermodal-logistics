require("scripts.util.stringify");

---@class IntermodalLogisticsPipeline
---Properties:
---@field gantries GantryPrototype[]
---@field gantry_rails GantryRailPrototype[]
---@field small_containers SmallContainerPrototype[]
---@field large_containers LargeContainerPrototype[]
---@field small_container_docks SmallContainerDockPrototype[]
---@field large_container_docks LargeContainerDockPrototype[]
---@field container_wagons ContainerWagonPrototype[]
---@field container_ships ContainerShipPrototype[]
---Methods:
---@field add_gantry_prototype fun(self: IntermodalLogisticsPipeline, gantry_prototype: GantryPrototype) Adds a gantry prototype to the pipeline.
---@field add_gantry_rail_prototype fun(self: IntermodalLogisticsPipeline, gantry_rail_prototype: GantryRailPrototype) Adds a gantry rail prototype to the pipeline.
---@field add_small_container_prototype fun(self: IntermodalLogisticsPipeline, small_container_prototype: SmallContainerPrototype) Adds a small container prototype to the pipeline.
---@field add_large_container_prototype fun(self: IntermodalLogisticsPipeline, large_container_prototype: LargeContainerPrototype) Adds a large container prototype to the pipeline.
---@field add_small_container_dock_prototype fun(self: IntermodalLogisticsPipeline, small_dock_prototype: SmallContainerDockPrototype) Adds a small container dock prototype to the pipeline.
---@field add_large_container_dock_prototype fun(self: IntermodalLogisticsPipeline, large_dock_prototype: LargeContainerDockPrototype) Adds a large container dock prototype to the pipeline.
---@field add_container_wagon_prototype fun(self: IntermodalLogisticsPipeline, container_wagon_prototype: ContainerWagonPrototype) Adds a container wagon prototype to the pipeline.
---@field add_container_ship_prototype fun(self: IntermodalLogisticsPipeline, container_ship_prototype: ContainerShipPrototype) Adds a container ship prototype to the pipeline.
---@field send fun(self: IntermodalLogisticsPipeline) Packages the pipeline so it can be reaquired during the control stage.

---Constructor for an IntermodalLogisticsPipeline.
---@return IntermodalLogisticsPipeline # The constructed pipeline.
function make_intermodal_logistics_pipeline()
	---@type IntermodalLogisticsPipeline
	local intermodal_logistics_pipeline = {
		gantries = {},
		gantry_rails = {},
		small_containers = {},
		large_containers = {},
		small_container_docks = {},
		large_container_docks = {},
		container_wagons = {},
		container_ships = {},
	};

	function intermodal_logistics_pipeline:add_gantry_prototype(gantry_prototype)
		table.insert(self.gantries, gantry_prototype);
	end

	function intermodal_logistics_pipeline:add_gantry_rail_prototype(gantry_rail_prototype)
		table.insert(self.gantry_rails, gantry_rail_prototype);
	end

	function intermodal_logistics_pipeline:add_small_container_prototype(small_container_prototype)
		table.insert(self.small_containers, small_container_prototype);
	end

	function intermodal_logistics_pipeline:add_large_container_prototype(large_container_prototype)
		table.insert(self.large_containers, large_container_prototype);
	end

	function intermodal_logistics_pipeline:add_small_container_dock_prototype(small_container_dock_prototype)
		table.insert(self.small_container_docks, small_container_dock_prototype);
	end

	function intermodal_logistics_pipeline:add_large_container_dock_prototype(large_container_dock_prototype)
		table.insert(self.large_container_docks, large_container_dock_prototype);
	end

	function intermodal_logistics_pipeline:add_container_wagon_prototype(container_wagon_prototype)
		table.insert(self.container_wagons, container_wagon_prototype);
	end

	function intermodal_logistics_pipeline:add_container_ship_prototype(container_ship_prototype)
		table.insert(self.container_ships, container_ship_prototype);
	end

	---Packages the pipeline so it can be reaquired during the control stage.
	function intermodal_logistics_pipeline:send()
		local dump = serpent.dump(intermodal_logistics_game);

		local mutilated_data = {};

		local first = 1;
		local last = 200;
		local number_of_characters = #dump;

		if (number_of_characters > 8000) then
			error("You ran out of characters nerd. Limit 8000, used " .. tostring(number_of_characters));
		end

		while first <= number_of_characters do
			table.insert(mutilated_data, string.sub(dump, first, math.min(last, number_of_characters)));
			first = first + 200;
			last = last + 200;
		end

		data:extend { {
			-- Can get 8000 characters via these two string arrays
			-- Table limited to 20 entries.
			localised_description = { table.unpack(mutilated_data, 1, 200) },
			-- Table limited to 20 entries.
			localised_name = #mutilated_data < 201 and { "" } or { table.unpack(mutilated_data, 201, 400) },
			name = "gantry-data-control-pipeline-0",
			type = "recipe-category",
			--group = "gantry-group";
		} };
	end

	return intermodal_logistics_pipeline;
end

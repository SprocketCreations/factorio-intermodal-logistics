require("scripts.util.stringify");

---@class IntermodalLogisticsPipeline
---Properties:
---@field rails RailPrototype[]
---@field gantries GantryPrototype[]
---@field docks DockPrototype[]
---@field containers ContainerPrototype[]
---@field container_wagons ContainerWagonPrototype[]
---@field container_ships ContainerShipPrototype[]
---Methods:
---@field add_gantry_prototype fun(self: IntermodalLogisticsPipeline, gantry_prototype: GantryPrototype) Adds a gantry prototype to the pipeline.
---@field add_dock_prototype fun(self: IntermodalLogisticsPipeline, dock_prototype: DockPrototype) Adds a dock prototype to the pipeline.
---@field add_container_prototype fun(self: IntermodalLogisticsPipeline, container_prototype: ContainerPrototype) Adds a container prototype to the pipeline.
---@field add_container_wagon_prototype fun(self: IntermodalLogisticsPipeline, container_wagon_prototype: ContainerWagonPrototype) Adds a container wagon prototype to the pipeline.
---@field add_container_ship_prototype fun(self: IntermodalLogisticsPipeline, container_ship_prototype: ContainerShipPrototype) Adds a container ship prototype to the pipeline.
---@field send fun(self: IntermodalLogisticsPipeline) Packages the pipeline so it can be reaquired during the control stage.

---Constructor for an IntermodalLogisticsPipeline.
---@return IntermodalLogisticsPipeline # The constructed pipeline.
function make_intermodal_logistics_pipeline()
	---@type IntermodalLogisticsPipeline
	local intermodal_logistics_pipeline = {
		gantries = {},
		docks = {},
		containers = {},
		container_wagons = {},
		container_ships = {},
	};

	---Adds a gantry prototype to the pipeline.
	---@param gantry_prototype GantryPrototype
	function intermodal_logistics_pipeline:add_gantry_prototype(gantry_prototype)
		table.insert(self.gantries, gantry_prototype);
	end

	---Adds a dock prototype to the pipeline.
	---@param dock_prototype DockPrototype
	function intermodal_logistics_pipeline:add_dock_prototype(dock_prototype)
		table.insert(self.docks, dock_prototype);
	end

	---Adds a container prototype to the pipeline.
	---@param container_prototype ContainerPrototype
	function intermodal_logistics_pipeline:add_container_prototype(container_prototype)
		table.insert(self.containers, container_prototype);
	end

	---Adds a container wagon prototype to the pipeline.
	---@param container_wagon_prototype ContainerWagonPrototype
	function intermodal_logistics_pipeline:add_container_wagon_prototype(container_wagon_prototype)
		table.insert(self.container_wagons, container_wagon_prototype);
	end

	---Adds a container ship prototype to the pipeline.
	---@param container_ship_prototype ContainerShipPrototype
	function intermodal_logistics_pipeline:add_container_ship_prototype(container_ship_prototype)
		table.insert(self.container_ships, container_ship_prototype);
	end

	---Packages the pipeline so it can be reaquired during the control stage.
	function intermodal_logistics_pipeline:send()
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
			name = "gantry-data-control-pipeline-0",
			type = "recipe-category",
			--group = "gantry-group";
		} };
	end

	return intermodal_logistics_pipeline;
end

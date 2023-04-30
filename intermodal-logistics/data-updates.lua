require("scripts.data.parse.gantry");
require("scripts.data.parse.gantry-rail");
-- require("scripts.data.parse.small-container");
require("scripts.data.parse.large-container");
-- require("scripts.data.parse.small-container-dock");
require("scripts.data.parse.large-container-dock");
-- require("scripts.data.parse.container-wagon");
-- require("scripts.data.parse.container-ship");

require("scripts.intermodal-logistics-pipeline");

---@type IntermodalLogisticsPipeline
intermodal_logistics_pipeline = make_intermodal_logistics_pipeline();

---Iterates over every item in a table and calls callback.
---@param table table
---@param callback fun(prototype: string): string
function for_each(table, callback)
	for i, element in pairs(table) do
		callback(element);
	end
end

local raw = intermodal_logistics_data.raw;
for_each(raw["gantry"], parse_gantry);
for_each(raw["gantry-rail"], parse_gantry_rail);
-- for_each(raw["small-container"], parse_small_container);
for_each(raw["large-container"], parse_large_container);
-- for_each(raw["small-container-dock"], parse_small_container_dock);
for_each(raw["large-container-dock"], parse_large_container_dock);
-- for_each(raw["container-wagon"], parse_container_wagon);
-- for_each(raw["container-ship"], parse_container_ship);

intermodal_logistics_pipeline:send();

intermodal_logistics_data = nil;
intermodal_logistics_pipeline = nil;

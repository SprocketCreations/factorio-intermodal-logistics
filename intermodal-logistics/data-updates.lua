require("scripts.data.parse-gantry");
require("scripts.data.parse-dock");
require("scripts.data.send-game-to-pipeline");

---@type IntermodalLogisticsPipeline
intermodal_logistics_pipeline = make_intermodal_logistics_pipeline();

for _, raw_gantry in pairs(intermodal_logistics_data.raw.gantry) do
	parse_gantry(raw_gantry);
end
for _, raw_dock in pairs(intermodal_logistics_data.raw.dock) do
	--parse_dock(raw_dock);
end
for _, raw_container in pairs(intermodal_logistics_data.raw.container) do
	parse_container(raw_container);
end
for _, raw_container_wagon in pairs(intermodal_logistics_data.raw.container_wagon) do
	--parse_container_wagon(raw_container_wagon);
end
for _, raw_container_ship in pairs(intermodal_logistics_data.raw.container_ship) do
	--parse_container_ship(raw_container_ship);
end

--...and shipped it off to squid kid's island!
intermodal_logistics_pipeline:send();

-- Yeet
intermodal_logistics_data = nil;
intermodal_logistics_pipeline = nil;

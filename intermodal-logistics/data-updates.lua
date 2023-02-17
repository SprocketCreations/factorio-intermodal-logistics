require("scripts.data.parse-gantry");
require("scripts.data.send-game-to-pipeline");

---@type IntermodalLogisticsGame
local intermodal_logistics_game = {
	gantries = {},
	docks = {},
	container_wagons = {},
	container_ships = {},
};

for _, raw_gantry in pairs(intermodal_logistics_data.raw.gantry) do
	parse_gantry(raw_gantry);
end
for _, raw_dock in pairs(intermodal_logistics_data.raw.dock) do
	--parse_dock(raw_dock);
end
for _, raw_container_wagon in pairs(intermodal_logistics_data.raw.container_wagon) do
	--parse_container_wagon(raw_container_wagon);
end
for _, raw_container_ship in pairs(intermodal_logistics_data.raw.container_ship) do
	--parse_container_ship(raw_container_ship);
end

send_game_to_pipeline(intermodal_logistics_game);

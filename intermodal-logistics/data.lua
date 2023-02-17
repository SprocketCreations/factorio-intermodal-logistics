
---@class IntermodalLogisticsData
---@field raw table<string, table> The raw prototypes wating to be initialized.
---@field raw.gantry table Prototypes for gantries.
---@field raw.dock table Prototypes for docks.
---@field raw.container-wagon table Prototypes for container wagons.
---@field raw.container-ship table Prototypes for container ships.

---@type IntermodalLogisticsData All the prototypes will be collected here.
intermodal_logistics_data = {
	raw = {};
};
---Registers one or more custom prototypes with the intermodal logistics mod.
---@param prototypes table[] An array of prototypes.
function intermodal_logistics_data:extend(prototypes)
	for _, prototype in pairs(prototypes) do
		if(self.raw[prototype.type] == nil) then
			error("Intermodal Logistics Error: " .. prototype.type .. " is not a valid type.")
		end
		table.insert(self.raw[prototype.type], prototype);
	end
end


require("prototypes.group")
require("prototypes.item");
require("prototypes.style");
require("prototypes.sprite");
require("prototypes.entity");

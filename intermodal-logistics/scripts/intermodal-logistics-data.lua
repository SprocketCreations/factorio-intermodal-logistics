---@class IntermodalLogisticsData
---Properties:
---@field raw table<string, table> The raw prototypes wating to be initialized.
---@field raw.gantry table Prototypes for gantries.
---@field raw.gantry-rail table Prototypes for gantry rails.
---@field raw.small-container table Prototypes for half sized containers.
---@field raw.large-container table Prototypes for containers.
---@field raw.small-container-dock table Prototypes for half sized container docks.
---@field raw.large-container-dock table Prototypes for container docks.
---@field raw.container-wagon table Prototypes for container wagons.
---@field raw.container-ship table Prototypes for container ships.
---Methods:
---@field extend fun(self: IntermodalLogisticsData, prototypes: table[]) Registers one or more custom prototypes with the intermodal logistics mod.

---Constructor for 'IntermodalLogisticsData'
---@return IntermodalLogisticsData # The constructed object.
function make_intermodal_logistics_data()
	local intermodal_logistics_data = {
		raw = {
			["gantry"] = {},
			["gantry-rail"] = {},
			["small-container"] = {},
			["large-container"] = {},
			["small-container-dock"] = {},
			["large-container-dock"] = {},
			["container-wagon"] = {},
			["container-ship"] = {},
		},
	};

	---Registers one or more custom prototypes with the intermodal logistics mod.
	---@param self IntermodalLogisticsData self
	---@param prototypes table[] An array of prototypes.
	function intermodal_logistics_data:extend(prototypes)
		for _, prototype in pairs(prototypes) do
			if (self.raw[prototype.type] == nil) then
				error(prototype.type .. " is not a valid type.")
			end
			table.insert(self.raw[prototype.type], prototype);
		end
	end

	return intermodal_logistics_data;
end

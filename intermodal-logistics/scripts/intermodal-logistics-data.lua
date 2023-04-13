---@class IntermodalLogisticsData
---Properties:
---@field raw table<string, table> The raw prototypes wating to be initialized.
---@field raw.rail table Prototypes for rails.
---@field raw.gantry table Prototypes for gantries.
---@field raw.dock table Prototypes for docks.
---@field raw.container table Prototypes for containers.
---@field raw.container-wagon table Prototypes for container wagons.
---@field raw.container-ship table Prototypes for container ships.
---Methods:
---@field extend fun(prototypes: table[]) Registers one or more custom prototypes with the intermodal logistics mod.

---Constructor for 'IntermodalLogisticsData'
---@return IntermodalLogisticsData # The constructed object.
function make_intermodal_logistics_data()
	local intermodal_logistics_data = {
		raw = {
			["rail"] = {},
			["gantry"] = {},
			["container"] = {},
			["dock"] = {},
			["container-wagon"] = {},
			["container-ship"] = {},
		},
	};

	---Registers one or more custom prototypes with the intermodal logistics mod.
	---@param prototypes table[] An array of prototypes.
	function intermodal_logistics_data:extend(prototypes)
		for _, prototype in pairs(prototypes) do
			if (self.raw[prototype.type] == nil) then
				error("Intermodal Logistics Error: " .. prototype.type .. " is not a valid type.")
			end
			table.insert(self.raw[prototype.type], prototype);
		end
	end

	return intermodal_logistics_data;
end

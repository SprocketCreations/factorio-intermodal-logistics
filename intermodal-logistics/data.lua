---All the prototypes will be collected here.
intermodal_logistics = {
	---@type table[] Array of prototype types.
	raw = {};
};
---Registers one or more custom prototypes with the intermodal logistics mod.
---@param prototypes table[]
function intermodal_logistics:extend(prototypes)
	for _, prototype in pairs(prototypes) do
		if(self.raw[prototype.type] == nil) then
			self.raw[prototype.type] = {};
		end
		table.insert(self.raw[prototype.type], prototype);
	end
end


require("prototypes.group")
require("prototypes.item");
require("prototypes.style");
require("prototypes.sprite");
require("prototypes.entity");

gantry = {
	raw = {};
};
function gantry:extend(table)
	for i, g in pairs(table) do
		table.insert(self.raw[g.type], g);
	end
end



require("prototypes.group")
require("prototypes.item");
require("prototypes.style");
require("prototypes.sprite");
require("prototypes.entity");
require("scripts.util.assert");
---Takes the dev given table of container configuration and mutates it to be more useable.
---@param raw_container table
---@return table
function verify_raw_container(raw_container)
	assert_type(raw_container, "table", "raw_container must be a table.");
	return {
		container = raw_container;
	};
end
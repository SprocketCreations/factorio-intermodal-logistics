
function stringify_boolean(b)
	return b and "true" or "false";
end

function stringify_number(n)
	return tostring(n);
end

function stringify_string(s)
	return '"' .. tostring(s) .. '"';
end

function stringify_nil(n)
	return "nil";
end

function stringify_table(t)
	local out = {};
	local first = true;
	table.insert(out);
	for key, value in pairs(t) do
		local switch = {
			boolean = stringify_boolean;
			number = stringify_number;
			["nil"] = stringify_nil;
			string = stringify_string;
			table = stringify_table;
		};
		local keyType = type(key);
		local valueType = type(value);
		
		local key_stringify = switch[keyType];
		local value_stringify = switch[valueType];

		if(key_stringify ~= nil and value_stringify ~= nil) then
			if(not first) then
				first = false;
				-- Comma between each key/value pair
				table.insert(out, ",");
			end
			
			local stringified_key = key_stringify(key);
			local stringified_value = value_stringify(value);
			table.insert(out, stringified_key);
			table.insert(out, ":");
			table.insert(out, stringified_value);
		end
	end
	return table.concat(out);
end



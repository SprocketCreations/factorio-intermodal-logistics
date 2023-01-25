
--[[
	converts a number into a string with the decimals chopped off and letters added to indicate k/M/G
]]
local prettify_number = function(number)
	local value = number;
	local text = "";
	if (value >= 1000000000) then
		-- Billion
		local value = math.floor(value / 100000000) / 10;
		text = tostring(value);
		if (value == math.floor(value)) then
			text = text .. ".0";
		end
		text = text .. "G";
	elseif (value >= 100000000) then
		-- Hundred Million
		text = tostring(math.floor(value / 1000000)) .. "M";
	elseif (value >= 10000000) then
		-- Ten Million
		text = tostring(math.floor(value / 1000000)) .. "M";
	elseif (value >= 1000000) then
		-- Million
		local value = math.floor(value / 100000) / 10;
		text = tostring(value);
		if (value == math.floor(value)) then
			text = text .. ".0";
		end
		text = text .. "M";
	elseif (value >= 100000) then
		-- Hundren Thousand
		text = tostring(math.floor(value / 1000)) .. "k";
	elseif (value >= 10000) then
		-- Ten Thousand
		text = tostring(math.floor(value / 1000)) .. "k";
	elseif (value >= 1000) then
		-- Thousand
		local value = math.floor(value / 100) / 10;
		text = tostring(value);
		if (value == math.floor(value)) then
			text = text .. ".0";
		end
		text = text .. "k";
	else
		-- Hundreds and so on
		text = number;
	end
	return text;
end

return prettify_number;

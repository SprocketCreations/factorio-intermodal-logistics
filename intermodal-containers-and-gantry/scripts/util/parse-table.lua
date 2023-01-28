local number_characters = { ["-"] = 4, ["0"] = 4, ["1"] = 4, ["2"] = 4, ["3"] = 4, ["4"] = 4, ["5"] = 4, ["6"] = 4,
	["7"] = 4, ["8"] = 4, ["9"] = 4, ["."] = 4 };

local letter_at = function(s, i)
	return s:sub(i, i);
end

local is_table = function(character)
	return character == "{";
end

local is_whitespace = function(character)
	local whitespace_characters = {
		[" "] = 3,
		["\n"] = 3,
		["\r"] = 3,
		["	"] = 3,
	};
	return whitespace_characters[character] == 3;
end

local is_comma = function(character)
	return character == ",";
end

local is_colon = function(character)
	return character == ":";
end

local is_string = function(character)
	return character == '"';
end

local is_number = function(character)

	return number_characters[character] == 4;
end

local is_true = function(character)
	return character == "t";
end

local is_false = function(character)
	return character == "f";
end

local is_nil = function(character)
	return character == "n";
end

local parse_string = function(s, starting_index)
	local str = { '"' };
	local last_character_was_escape = false;
	for i = starting_index, #s, 1 do
		local letter = letter_at(s, i);
		table.insert(str, letter);
		if (last_character_was_escape) then
			last_character_was_escape = false;
		else
			if (letter == '"') then
				return i, table.concat(str);
			elseif (letter == "\\") then
				last_character_was_escape = true;
			end
		end
	end
	return (#s) + 1, table.concat(str);
end

local parse_number = function(s, starting_index)
	for i = starting_index, #s, 1 do
		local letter = letter_at(s, i);
		if (number_characters[letter] ~= 4) then
			-- We have reached the end of the number.
			return i, tonumber(string.sub(s, starting_index, i - 1));
		end
	end
	return (#s) + 1, tonumber(string.sub(s, starting_index, #s));
end

local parse_true = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == 4) then
			return i + 1, true;
		end
	end
	return (#s) + 1, true;
end

local parse_false = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == 5) then
			return i + 1, false;
		end
	end
	return (#s) + 1, false;
end

local parse_nil = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == 3) then
			return i + 1, nil;
		end
	end
	return (#s) + 1, nil;
end

function parse_table(s, starting_index)
	starting_index = starting_index or 1;
	local searching_for_key = true;
	local t = {};
	local key;
	for i = starting_index, #s, 1 do
		local letter = letter_at(s, i);
		local out = nil;
		if (letter == "}") then
			return i, t;
		elseif (is_colon(letter)) then
			searching_for_key = false;
		elseif (is_comma(letter)) then
			searching_for_key = true;
		elseif (is_string(letter)) then
			i, out = parse_string(s, i);
		elseif (is_number(letter)) then
			i, out = parse_number(s, i);
		elseif (is_true(letter)) then
			i, out = parse_true(s, i);
		elseif (is_false(letter)) then
			i, out = parse_false(s, i);
		elseif (is_nil(letter)) then
			i, out = parse_nil(s, i);
		elseif (is_table(letter)) then
			i, out = parse_table(s, i);
		end
		if (searching_for_key) then
			key = out;
		else
			t[key] = out;
		end
	end

	return (#s) + 1, t;
end

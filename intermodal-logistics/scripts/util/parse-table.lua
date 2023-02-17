local number_characters = { ["-"] = 4, ["0"] = 4, ["1"] = 4, ["2"] = 4, ["3"] = 4, ["4"] = 4, ["5"] = 4, ["6"] = 4,
	["7"] = 4, ["8"] = 4, ["9"] = 4, ["."] = 4 };

local letter_at = function(s, i)
	return string.sub(s, i, i);
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
	local str = {};
	local last_character_was_escape = false;
	for i = starting_index + 1, #s, 1 do
		local letter = letter_at(s, i);
		if (last_character_was_escape) then
			last_character_was_escape = false;
		else
			if (letter == '"') then
				return table.concat(str), i;
			elseif (letter == "\\") then
				last_character_was_escape = true;
			end
		end
		table.insert(str, letter);
	end
	return table.concat(str), (#s);
end

local parse_number = function(s, starting_index)
	for i = starting_index, #s, 1 do
		local letter = letter_at(s, i);
		if (number_characters[letter] ~= 4) then
			-- We have reached the end of the number.
			return tonumber(string.sub(s, starting_index, i - 1)), i - 1;
		end
	end
	return tonumber(string.sub(s, starting_index, #s)), (#s);
end

local parse_true = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == starting_index + 4) then
			return true, i;
		end
	end
	return true, (#s);
end

local parse_false = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == starting_index + 5) then
			return false, i;
		end
	end
	return false, (#s);
end

local parse_nil = function(s, starting_index)
	for i = starting_index, #s, 1 do
		if (i == starting_index + 3) then
			return nil, i;
		end
	end
	return nil, (#s);
end

function parse_table(s, starting_index)
	if(starting_index == nil) then
		starting_index = 1;
		for i = starting_index, #s, 1 do
			starting_index = i;
			local letter = letter_at(s, i)
			if(is_table(letter)) then
				break;
			end
		end
		if(starting_index == #s) then
			error("Malformed jsnot string. Could not find '{'");
		end
	end
	starting_index = starting_index + 1;
	local searching_for_key = true;
	local t = {};
	local key;
	local i = starting_index;
	while (i <= #s) do
		local letter = letter_at(s, i);
		local out = nil;
		if (letter == "}") then
			return t, i;
		elseif (is_colon(letter)) then
			searching_for_key = false;
		elseif (is_comma(letter)) then
			searching_for_key = true;
		elseif (is_string(letter)) then
			out, i = parse_string(s, i);
		elseif (is_number(letter)) then
			out, i = parse_number(s, i);
		elseif (is_true(letter)) then
			out, i = parse_true(s, i);
		elseif (is_false(letter)) then
			out, i = parse_false(s, i);
		elseif (is_nil(letter)) then
			out, i = parse_nil(s, i );
		elseif (is_table(letter)) then
			out, i = parse_table(s, i );
		end
		if (searching_for_key) then
			key = out;
		else
			t[key] = out;
		end
		i = i + 1;
	end

	return t, (#s) + 1;
end

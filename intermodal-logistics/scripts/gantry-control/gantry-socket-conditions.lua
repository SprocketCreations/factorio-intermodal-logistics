---Checks if an entity meets a specific condition.
---@param socket_conditional table The condition to check.
---@param entity LuaEntity The entity to check.
---@return boolean # true if the entity meets the condition.
function socket_conditional_entity_meets_condition(socket_conditional, entity)
	---@type { [string]: fun(): boolean }
	local switch = {
		["time-passed"] = function()
		end;
		["inactivity"] = function()
		end;
		["full-cargo"] = function()
		end;
		["empty-cargo"] = function()
		end;
		["item-count"] = function()
		end;
		["circuit-condition"] = function()
		end;
	};
	local handler = switch[socket_conditional.type];
	if (handler ~= nil) then
		return handler();
	end
	return false;
end

---@param socket_conditional SocketConditional self.
---@return boolean # true if every operator in this contional is the same.
function socket_conditional_do_all_operators_match(socket_conditional)
	if (#socket_conditional.conditions < 5) then return true; end
	local first_operator = socket_conditional.conditions[2];

	for i = 4, #socket_conditional.conditions, 2 do
		local next_operator = socket_conditional.conditions[i];
		if (first_operator ~= next_operator) then
			return false;
		end
		first_operator = next_operator;
	end
	return true;
end

---Adds the time passed condition to the conditional.
---@param socket_conditional SocketConditional
---@param duration? number The time in seconds that need to have passed. Defaults to 30.
---@return table # the condition created.
function socket_conditional_add_time_passed_condition(socket_conditional, duration)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "time-passed",
		time = duration or 30,
	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

---Adds the inactivity condition to the conditional.
---@param socket_conditional SocketConditional
---@param duration? number The time in seconds that need to be inactive. Defaults to 5.
---@return table # the condition created.
function socket_conditional_add_inactivity_condition(socket_conditional, duration)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "inactivity",
		time = duration or 5,
	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

---Adds the full condition to the conditional.
---@param socket_conditional SocketConditional
---@return table # the condition created.
function socket_conditional_add_full_condition(socket_conditional)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "full-cargo",
	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

---Adds the empty condition to the conditional.
---@param socket_conditional SocketConditional
---@return table # the condition created.
function socket_conditional_add_empty_condition(socket_conditional)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "empty-cargo",
	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

---Adds the item count condition to the conditional.
---@param socket_conditional SocketConditional
---@param constant? number The constant number. Defaults to 0.
---@return table # the condition created.
function socket_conditional_add_item_count_condition(socket_conditional, constant)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "item-count",
		left_item = nil,
		right_signal = nil,
		comparator = 2,
		constant = constant or 0,
		use_constant = true,
	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

---Adds the circuit condition to the conditional.
---@param socket_conditional SocketConditional
---@param constant? number The constant number. Defaults to 0.
---@return table # the condition created.
function socket_conditional_add_circuit_condition(socket_conditional, constant)
	socket_conditional_add_operator(socket_conditional, "OR");
	local condition = {
		type = "circuit-condition",
		left_signal = nil,
		right_signal = nil,
		comparator = 2,
		constant = constant or 0,
		use_constant = true,

	};
	table.insert(socket_conditional.conditions, condition);
	return condition;
end

-- Removes the condition at index. So if this is the third condition in the interface, set index to 3.
---@param socket_conditional SocketConditional self.
---@param index number
function socket_conditional_remove_condition(socket_conditional, index)
	index = index * 2 - 1;
	-- There is no operator before the first condition to destroy,
	-- but we do need to destroy the next one.
	if (index == 1) then
		table.remove(socket_conditional.conditions, index + 1);
	end
	-- Remove the conditional at the index
	table.remove(socket_conditional.conditions, index);

	-- If this is not the first conditional, we need to remove the
	-- operator before it.
	if (index ~= 1) then
		table.remove(socket_conditional.conditions, index - 1);
	end

	-- The elements are removed from the list starting at the highest
	--index and moving down because otherwise the indicies of the elements
	--would change after calling table.remove().
end

-- Moves the condition at the given index up one slot, swapping places with the condition above it.
---@param socket_conditional SocketConditional self.
---@param index number
function socket_conditional_move_condition_up(socket_conditional, index)
	index = index * 2 - 1;
	if (index == 1) then
		-- Idk throw an error maybe?
	else
		local above_condition = socket_conditional.conditions[index - 2];
		socket_conditional.conditions[index - 2] = socket_conditional.conditions[index];
		socket_conditional.conditions[index] = above_condition;
	end
end

---Moves the condition at the given index down one slot, swapping places with the condition below it.
---@param socket_conditional SocketConditional self.
---@param index number
function socket_conditional_move_condition_down(socket_conditional, index)
	index = index * 2 - 1;
	if (index == #(socket_conditional.conditions)) then
		-- Idk throw an error maybe?
	else
		local below_condition = socket_conditional.conditions[index + 2];
		socket_conditional.conditions[index + 2] = socket_conditional.conditions[index];
		socket_conditional.conditions[index] = below_condition;
	end
end

---@param socket_conditional SocketConditional self.
---@param operator_type "AND" | "OR"
function socket_conditional_add_operator(socket_conditional, operator_type)
	if (#socket_conditional.conditions ~= 0) then
		if (operator_type == "AND") then
			table.insert(socket_conditional.conditions, "AND");
		elseif (operator_type == "OR") then
			table.insert(socket_conditional.conditions, "OR");
		else
			error("invalid operator passed in to function: " + operator_type);
		end
	end
end

---Index is the nth condition. There will never be a condition 1.
---@param socket_conditional SocketConditional self.
---@param index number
function socket_conditional_toggle_comparison_operator(socket_conditional, index)
	index = index * 2 - 2;
	local swap = {
		["AND"] = "OR",
		["OR"] = "AND",
	};
	socket_conditional.conditions[index] = swap[socket_conditional.conditions[index]];
end

---@param conditional SocketConditional self.
---@param index number
---@return table|string # the nth condition.
function conditional_get_condition(conditional, index)
	index = index * 2 - 1;
	return conditional.conditions[index];
end

-- Checks a given entity to see if it meets the conditions layed out in this object.<br>
-- TODO: Optimize this function:<br>
-- do all the meets_conditions calls when shallow copying the array.<br>
-- the ors can be compressed into a i or i - 1 or i - 2 sort of thing.<br>
-- if all the operators match, we can just use a simpler algorithm
---@param socket_conditional SocketConditional self.
---@param entity LuaEntity The socket entity.
---@return boolean # the result of all the conditions
function socket_conditional_meets_conditions(socket_conditional, entity)
	local conditions_copy = {};
	--loop over the conditions array and make a shallow
	--copy of each entry for the next step.
	for _, condition in socket_conditional.conditions do
		--shallow copy the table
		conditions_copy.insert(condition);
	end

	--Now resolve all the ands going from
	--left to right.
	for i = 1, #conditions_copy, 1 do
		--grab a ref to the condition before we
		--mess with the array.
		local condition = conditions_copy[i];
		-- if this is the next and to process
		if (condition == "AND") then
			--get the right element first (and remove it)
			local right = conditions_copy.remove(i + 1);
			--get the left element (and remove it)
			local left = conditions_copy.remove(i - 1);
			--decrement i to compensate for removing left
			i = i - 1;
			--compare them
			local compare = socket_conditional_entity_meets_condition(left, entity) and socket_conditional_entity_meets_condition(right, entity);
			-- replace the operator with the output (true or false)
			conditions_copy[i] = compare;
		end
	end

	--Now resolve all the ors going from
	--left to right.
	for i = 1, #conditions_copy, 1 do
		--grab a ref to the condition before we
		--mess with the array.
		local condition = conditions_copy[i];
		-- if this is the or and to process
		if (condition == "OR") then
			--get the right element first (and remove it)
			local right = conditions_copy.remove(i + 1);
			--get the left element (and remove it)
			local left = conditions_copy.remove(i - 1);
			--decrement i to compensate for removing left
			i = i - 1;
			--compare them
			local compare = left or right;
			-- replace the operator with the output (true or false)
			conditions_copy[i] = compare;
		end
	end

	--there should only be one element left in the array
	--at this point, so just return it.
	return conditions_copy[1];
end

---@class SocketConditional
---@field package conditions (table | string)[]

---Constructor for a SocketConditional
---@return SocketConditional
function make_socket_conditional()
	---@type SocketConditional
	local socket_conditional = {

		-- An array of conditions.
		-- Every even element is the comparison operator between the previous
		--and next condition. All the "and" operators will be processed first,
		--then the "or" operators.
		-- Yes this array weaving is cursed. No i dont care.
		conditions = {};
	};

	-- Conditionals should have the default condition of
	socket_conditional_add_inactivity_condition(socket_conditional, 5);
	return socket_conditional;
end

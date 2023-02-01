function condition_meets_condition(condition, entity)
	local switch = {
		["time-elapsed"] = function()
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
	local handler = switch[condition.type];
	if (handler ~= nil) then
		return handler();
	end
	return false;
end

-- Returns true if every operator in this contional
-- is the same
function conditional_do_all_operators_match(conditional)
	if (#conditional.conditions < 5) then return true; end
	local first_operator = conditional.conditions[2];

	for i = 4, #conditional.conditions, 2 do
		local next_operator = conditional.conditions[i];
		if (first_operator ~= next_operator) then
			return false;
		end
		first_operator = next_operator;
	end
	return true;
end

function conditional_add_time_elapsed_condition(conditional, duration)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "time-elapsed",
		time = duration or 30,
	};
	table.insert(conditional.conditions, condition);
	return condition;
end

function conditional_add_inactivity_condition(conditional, duration)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "inactivity",
		time = duration or 5,
	};
	table.insert(conditional.conditions, condition);
	return condition;
end

function conditional_add_full_condition(conditional)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "full-cargo",
	};
	table.insert(conditional.conditions, condition);
	return condition;
end

function conditional_add_empty_condition(conditional)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "empty-cargo",
	};
	table.insert(conditional.conditions, condition);
	return condition;
end

function conditional_add_item_count_condition(conditional, constant)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "item-count",
		left_item = nil,
		right_signal = nil,
		comparator = 2,
		constant = 0,
		use_constant = true,
	};
	table.insert(conditional.conditions, condition);
	return condition;
end

function conditional_add_circuit_condition(conditional, constant)
	conditional_add_operator(conditional, "OR");
	local condition = {
		type = "circuit-condition",
		left_signal = nil,
		right_signal = nil,
		comparator = 2,
		constant = 0,
		use_constant = true,

	};
	table.insert(conditional.conditions, condition);
	return condition;
end

-- Removes the condition at index.
-- So if this is the third condition in the interface, set index to 3
function conditional_remove_condition(conditional, index)
	index = index * 2 - 1;
	-- There is no operator before the first condition to destroy,
	-- but we do need to destroy the next one.
	if (index == 1) then
		table.remove(conditional.conditions, index + 1);
	end
	-- Remove the conditional at the index
	table.remove(conditional.conditions, index);

	-- If this is not the first conditional, we need to remove the
	-- operator before it.
	if (index ~= 1) then
		table.remove(conditional.conditions, index - 1);
	end

	-- The elements are removed from the list starting at the highest
	--index and moving down because otherwise the indicies of the elements
	--would change after calling table.remove().
end

-- Moves the condition at the given index up one slot,
-- swapping places with the condition above it.
function conditional_move_condition_up(conditional, index)
	index = index * 2 - 1;
	if (index == 1) then
		-- Idk throw an error maybe?
	else
		local above_condition = conditional.conditions[index - 2];
		conditional.conditions[index - 2] = conditional.conditions[index];
		conditional.conditions[index] = above_condition;
	end
end

-- Moves the condition at the given index down one slot,
-- swapping places with the condition below it.
function conditional_move_condition_down(conditional, index)
	index = index * 2 - 1;
	if (index == #(conditional.conditions)) then
		-- Idk throw an error maybe?
	else
		local below_condition = conditional.conditions[index + 2];
		conditional.conditions[index + 2] = conditional.conditions[index];
		conditional.conditions[index] = below_condition;
	end
end

-- Valid operator types are "and" and "or"
function conditional_add_operator(conditional, operator_type)
	if (#conditional.conditions ~= 0) then
		if (operator_type == "AND") then
			table.insert(conditional.conditions, "AND");
		elseif (operator_type == "OR") then
			table.insert(conditional.conditions, "OR");
		else
			error("invalid operator passed in to function: " + operator_type);
		end
	end
end

-- Index is the nth condition. There will never be a condition 1.
function conditional_toggle_comparison_operator(conditional, index)
	index = index * 2 - 2;
	local swap = {
		["AND"] = "OR",
		["OR"] = "AND",
	};
	conditional.conditions[index] = swap[conditional.conditions[index]];
end

-- Returns the condition table for the nth condition
function conditional_get_condition(conditional, index)
	index = index * 2 - 1;
	return conditional.conditions[index];
end

-- Checks a given entity to see if it meets
--the conditions layed out in this object.<br>
-- TODO: Optimize this function<br>
-- do all the meets_conditions calls when shallow copying the array.<br>
-- the ors can be compressed into a i or i - 1 or i - 2 sort of thing.<br>
-- if all the operators match, we can just use a simpler algorithm
function conditional_meets_conditions(conditional, entity)
	local conditions_copy = {};
	--loop over the conditions array and make a shallow
	--copy of each entry for the next step.
	for _, condition in conditional.conditions do
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
			local compare = condition_meets_condition(left, entity) and condition_meets_condition(right, entity);
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

function make_conditional()
	local conditional = {};

	-- An array of conditions.
	-- Every even element is the comparison operator between the previous
	--and next condition. All the "and" operators will be processed first,
	--then the "or" operators.
	-- Yes this array weaving is cursed. No i dont care.
	conditional.conditions = {};

	-- Conditionals should have the default condition of
	conditional_add_inactivity_condition(conditional, 5);
	return conditional;
end

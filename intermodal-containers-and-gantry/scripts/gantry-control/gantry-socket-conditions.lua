local make_conditional = function()
	local conditional = {};

	-- An array of conditions.
	-- Every even element is the comparison operator between the previous
	--and next condition. All the "and" operators will be processed first,
	--then the "or" operators.
	-- Yes this array weaving is cursed. No i dont care.
	conditional.conditions = {};

	-- Returns true if every operator in this contional
	-- is the same
	function conditional:do_all_operators_match()
		if (#self.conditions < 5) then return true; end
		local first_operator = self.conditions[2];

		for i = 4, #self.conditions, 2 do
			local next_operator = self.conditions[i];
			if (first_operator ~= next_operator) then
				return false;
			end
			first_operator = next_operator;
		end
		return true;
	end

	function conditional:add_time_elapsed_condition(duration)
		self:add_operator("OR");
		local condition = {
			type = "time-elapsed",
			time = duration or 30,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	function conditional:add_inactivity_condition(duration)
		self:add_operator("OR");
		local condition = {
			type = "inactivity",
			time = duration or 5,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	function conditional:add_full_condition()
		self:add_operator("OR");
		local condition = {
			type = "full-cargo",
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	function conditional:add_empty_condition()
		self:add_operator("OR");
		local condition = {
			type = "empty-cargo",
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	function conditional:add_item_count_condition(constant)
		self:add_operator("OR");
		local condition = {
			type = "item-count",
			left_item = nil,
			right_signal = nil,
			comparitor = 2,
			constant = 0,
			use_constant = true,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	function conditional:add_circuit_condition(constant)
		self:add_operator("OR");
		local condition = {
			type = "circuit-condition",
			left_signal = nil,
			right_signal = nil,
			comparitor = 2,
			constant = 0,
			use_constant = true,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
		table.insert(self.conditions, condition);
		return condition;
	end

	-- Removes the condition at index.
	-- So if this is the third condition in the interface, set index to 3
	function conditional:remove_condition(index)
		index = index * 2 - 1;
		-- There is no operator before the first condition to destroy,
		-- but we do need to destroy the next one.
		if (index == 1) then
			table.remove(self.conditions, index + 1);
		end
		-- Remove the conditional at the index
		table.remove(self.conditions, index);

		-- If this is not the first conditional, we need to remove the
		-- operator before it.
		if (index ~= 1) then
			table.remove(self.conditions, index - 1);
		end

		-- The elements are removed from the list starting at the highest
		--index and moving down because otherwise the indicies of the elements
		--would change after calling table.remove().
	end

	-- Moves the condition at the given index up one slot,
	-- swapping places with the condition above it.
	function conditional:move_condition_up(index)
		index = index * 2 - 1;
		if (index == 1) then
			-- Idk throw an error maybe?
		else
			local above_condition = self.conditions[index - 2];
			self.conditions[index - 2] = self.conditions[index];
			self.conditions[index] = above_condition;
		end
	end

	-- Moves the condition at the given index down one slot,
	-- swapping places with the condition below it.
	function conditional:move_condition_down(index)
		index = index * 2 - 1;
		if (index == #(self.conditions)) then
			-- Idk throw an error maybe?
		else
			local below_condition = self.conditions[index + 2];
			self.conditions[index + 2] = self.conditions[index];
			self.conditions[index] = below_condition;
		end
	end

	-- Valid operator types are "and" and "or"
	function conditional:add_operator(operator_type)
		if (#self.conditions ~= 0) then
			if (operator_type == "AND") then
				table.insert(self.conditions, "AND");
			elseif (operator_type == "OR") then
				table.insert(self.conditions, "OR");
			else
				error("invalid operator passed in to function: " + operator_type);
			end
		end
	end

	-- Index is the nth condition. There will never be a condition 1.
	function conditional:toggle_comparison_operator(index)
		index = index * 2 - 2;
		local swap = {
			["AND"] = "OR",
			["OR"] = "AND",
		};
		self.conditions[index] = swap[self.conditions[index]];
	end

	-- Returns the condition table for the nth condition
	function conditional:get_condition(index)
		index = index * 2 - 1;
		return self.conditions[index];
	end

	-- Checks a given entity to see if it meets
	--the conditions layed out in this object.<br>
	-- TODO: Optimize this function<br>
	-- do all the meets_conditions calls when shallow copying the array.<br>
	-- the ors can be compressed into a i or i - 1 or i - 2 sort of thing.<br>
	-- if all the operators match, we can just use a simpler algorithm
	function conditional:meets_conditions(entity)
		local conditions_copy = {};
		--loop over the conditions array and make a shallow
		--copy of each entry for the next step.
		for _, condition in self.conditions do
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
				local compare = left:meets_condition(entity) and right:meets_condition(entity);
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

	-- Conditionals should have the default condition of
	conditional:add_inactivity_condition(5);
	return conditional;

end

return make_conditional;

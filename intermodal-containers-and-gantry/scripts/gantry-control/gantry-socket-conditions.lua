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
		self:add_operator("or");
		self.conditions.insert {
			type = "time-elapsed",
			time = 30,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	function conditional:add_inactivity_condition(duration)
		self:add_operator("or");
		self.conditions.insert {
			type = "inactivity",
			time = 5,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	function conditional:add_full_condition()
		self:add_operator("or");
		self.conditions.insert {
			type = "full-cargo",
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	function conditional:add_empty_condition()
		self:add_operator("or");
		self.conditions.insert {
			type = "empty-cargo",
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	function conditional:add_item_count_condition(constant)
		self:add_operator("or");
		self.conditions.insert {
			type = "item-count",
			left_item = "",
			right_item = "",
			comparitor = ">",
			constant = 0,
			use_constant = true,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	function conditional:add_circuit_condition(constant)
		self:add_operator("or");
		self.conditions.insert {
			type = "circuit-condition",
			left_signal = "",
			right_signal = "",
			comparitor = ">",
			constant = 0,
			use_constant = true,
			meets_condition = function(self, entity)
				--TODO: implement
				return false;
			end
		};
	end

	-- Valid operator types are "and" and "or"
	function conditional:add_operator(operator_type)
		if (#self.conditions ~= 0) then
			if (operator_type == "and") then
				self.conditions.insert("and");
			elseif (operator_type == "or") then
				self.conditions.insert("or");
			else
				error("invalid operator passed in to function: " + operator_type);
			end
		end
	end

	-- Checks a given entity to see if it meets
	--the conditions layed out in this object.<br>
	-- TODO: Optimize this function<br>
	-- do all the meets_conditions calls when shallow copying the array.<br>
	-- the ors can be compressed into a i or i - 1 or i - 2 sort of thing.<br>
	-- if all the operators match, we can just use a simpler algorithm
	function conditional:meets_conditions(entity)
		local conditions_copy = {};
		--loop over the conditionals array and make a shallow
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
			if (condition == "and") then
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
			if (condition == "or") then
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

	return conditional;

end

return make_conditional;

---Throws an error if a condition fails.
---@param condition boolean The condition to test. If it fails, an error will be thrown.
---@param message string? The message to display as the error.
function assert(condition, message)
	message = message or "An assert has failed a condition.";
	if (not condition) then
		error(message);
	end
end

---Throws an error if a condition fails.
---@param r any The object to check the type of.
---@param t string The type to check against.
---@param message string? The message to display as the error.
function assert_type(r, t, message)
	message = message or "An assert has failed a type check.";
	if (type(r) ~= t) then
		error(message);
	end
end

---Checks if a position is within a bounding box.
---@param bounding_box BoundingBox
---@param map_position MapPosition
---@return boolean # True if map_position is inside bounding box.
function bounding_box_is_position_inside(bounding_box, map_position)
	-- To the left
	if(map_position.x < bounding_box.left_top.x) then
		return false;
	end

	-- Above
	if(map_position.y > bounding_box.left_top.y) then
		return false;
	end

	-- Below
	if(map_position.y < bounding_box.right_bottom.y) then
		return false;
	end

	-- To the right
	if(map_position.x > bounding_box.right_bottom.x) then
		return false;
	end

	return true;
end

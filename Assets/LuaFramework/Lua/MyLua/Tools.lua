Tools = {}
function Tools:RemoveTableByValue(array, value)
	-- body
	local i,max = 1,#array
	while i<=max do
		if array[i] == value then
			table.remove(array, i)
			break
		end
	end
end

function Tools:TableContainsValue(array, value)
	-- body
	local i,max = 1,#array
	while i<=max do
		if array[i] == value then
			return true
		end
	end
	return false
end

function Tools:PointEquals(p1, p2)
	-- body
	if (p1.x == p2.x and p1.y == p2.y) then
		return true
	else
		return false
	end
end
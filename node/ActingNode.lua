ActingNode = class("ActingNode",NoLeafNode.new("actingnode"))

function ActingNode:ctor(nodeName,children)
	self.nodeName = nodeName
	self.__objecttype__ = "actingnode"
	self.children = children
end

function ActingNode:createNode(nodeName,children)
	return ActingNode.new(nodeName,children)
end

function ActingNode:execute(target, delta, deep)

	if(nil ~= self.currentActingNodeIndex)then
		local ret = self.children[self.currentActingNodeIndex]:execute(target, delta, deep + 1)
		if self.executeResultReacting ~= ret then 
			if self.executeResultActing ~= ret then
				self.currentActingNodeIndex = nil
			end
			return ret
		end
	end

	self.currentActingNodeIndex = nil

	local children = self.children
	for i = 1, #children do
		local ret = children[i]:execute(target, delta, deep + 1)
		if self.executeResultReacting ~= ret and executeResultReacting ~= executeResultTrue then 
			if self.executeResultActing == ret then
				self.currentActingNodeIndex = i	
			end
			return ret
		elseif self.executeResultReacting == ret then
			break
		end
	end

	return self.executeResultActing
end
SelectorNode = class("SelectorNode",NoLeafNode.new("selectornode"))

function SelectorNode:ctor(nodeName)
	self.nodeName = nodeName
	self.__objecttype__ = "selectornode"
	self.currentActingNodeIndex = nil
end

function SelectorNode:createNode(nodeName)
	return SelectorNode.new(nodeName)
end

function SelectorNode:execute(target, delta, deep)
	if nil ~= self.currentActingNodeIndex then
		local ret = self.children[self.currentActingNodeIndex]:execute(target, delta, deep + 1)
		if self.executeResultFalse ~= ret then
			if self.executeResultTrue == ret then
				self.currentActingNodeIndex = nil
			end
			return ret
		end
	end

	local index = 1
	if nil ~= self.currentActingNodeIndex then
		index = self.currentActingNodeIndex + 1	
		self.currentActingNodeIndex = nil
	end

	local children = self.children
	local ret = self.executeResultFalse
	for i = index, #children do
		ret = children[i]:execute(target, delta, deep + 1)
		if self.executeResultFalse ~= ret then 
			if self.executeResultActing == ret then
				self.currentActingNodeIndex = i	
			end
			break
		end
	end
	return ret
end

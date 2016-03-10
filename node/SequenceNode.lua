SequenceNode = class("SequenceNode",NoLeafNode.new("sequencenode"))
function SequenceNode:ctor(nodeName, func)
	self.nodeName = nodeName
	self.__objecttype__ = "sequencenode"
	self.currentActingNodeIndex = nil
end

function SequenceNode:createNode(nodeName)
	return SequenceNode.new(nodeName)
end

function SequenceNode:execute(target, delta, deep)
	if nil ~= self.currentActingNodeIndex then
		local ret = self.children[self.currentActingNodeIndex]:execute(target, delta, deep + 1)
		if self.executeResultTrue ~= ret then
			if self.executeResultFalse == ret then
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
	local ret = self.executeResultTrue
	for i = index, #children do
		ret = children[i]:execute(target, delta, deep + 1)
		if self.executeResultTrue ~= ret then
			if self.executeResultActing == ret then
				self.currentActingNodeIndex = i
			end
			break
		end
	end

	return ret
end

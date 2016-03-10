ConditionNode = class("ConditionNode",NoLeafNode.new("ConditionNode"))
function ConditionNode:ctor(nodeName, func)
	self.nodeName = nodeName
	self.__objecttype__ = "conditionactingnode"
	self.func = func
	if AIConfig and AIConfig.AI_RUNTIME_EFFECTE_CHECK then
		self.execute = self.executeWithCheck
	else
		self.execute = self.executeWithoutCheck
	end
end

function ConditionNode:createNode(nodeName, func)
	return ConditionNode.new(nodeName, func)
end

function ConditionNode:executeWithCheck(target, delta, deep)
	local begin = os.time()
	local ret = self.func(target, delta)
	local endTime = os.time()
	print("AI CHECK\t", self.nodeName, "\t", (endTime - begin))
	return ret
end

function ConditionNode:executeWithoutCheck(node, target, delta, deep)
	return self.func(target, delta)
end
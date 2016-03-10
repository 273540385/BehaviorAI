ConditionActingNode = class("ConditionActingNode",NoLeafNode.new("conditionactingnode"))

function ConditionActingNode:ctor(nodeName, conditionCheckNode, actionNodeForTrue, actionNodeForFalse)
	self.nodeName = nodeName
	self.__objecttype__ = "conditionactingnode"
	self.action = action
	self.conditionCheckNode = conditionCheckNode
	self.actionNodeForTrue = actionNodeForTrue
	self.actionNodeForFalse = actionNodeForFalse
	self.currentActingNode = nil
end

function ConditionActingNode:createNode(nodeName, conditionCheckNode, actionNodeForTrue, actionNodeForFalse)
	return ConditionActingNode.new(nodeName, conditionCheckNode, actionNodeForTrue, actionNodeForFalse)
end

function ConditionActingNode:addNode(...)
	assert(false, "Can't add child node to conditionactingnode")
end

function ConditionActingNode:execute(target, delta, deep)
	if(nil ~= self.currentActingNode)then
		local ret = self.currentActingNode:execute(target, delta, deep + 1)
		--如果子節點返回不是从新开始执行，那么就直接返回执行结果
		if(self.executeResultActing ~= ret)then --如果子节点返回不是继续执行，那么清除相关数据
			self.currentActingNode = nil
		end
		return ret
	end
	
	self.currentActingNode = nil

	local ret = self.conditionCheckNode:execute(target, delta, deep + 1)
	if(self.executeResultTrue == ret)then
		ret = self.actionNodeForTrue:execute(target, delta, deep + 1)
		self.currentActingNode = self.actionNodeForTrue
	elseif(executeResultFalse == ret)then
		ret = self.actionNodeForFalse:execute(target, delta, deep + 1)
		self.currentActingNode = self.actionNodeForFalse
	else
		assert(false, "Error conditon node return in conditionactingnode with name ".. self.nodeName.."\t"..self.conditionCheckNode.nodeName)
	end
	if(executeResultActing ~= ret)then
		self.currentActingNode = nil
	end
	return ret
end
ActionNode = class("NoLeafNode",LeafNode.new("actionnode"))

function ActingNode:ctor(nodeName, action, onRefresh)
	self.nodeName = nodeName
	self.__objecttype__ = "actionnode"
	self.action = action
	if AIConfig and AIConfig.AI_RUNTIME_EFFECTE_CHECK then
		self.execute = self.executeWithCheck
	else
		self.execute = self.executeWithoutCheck
	end
	if(nil ~= onRefresh)then
		self.onRefresh = function (self)
			
		end
	end
end

function ActingNode:createNode(nodeName, action, onRefresh)
	return ActingNode.new(nodeName, action, onRefresh)
end

function ActingNode:refresh(unit)
	self.onRefresh(unit)
end

function ActingNode:executeWithCheck(target, delta, deep)
	local begin = os.time()
	local ret = self.action(target, delta)
	local endTime = os.time()
	print("AI CHECK\t", self.nodeName, "\t", (endTime - begin))
	return ret
end

function ActingNode:executeWithoutCheck(target, delta, deep)
	if nil ==  self.action then
		print(self.nodeName)
	end
	local ret = self.action(target, delta)
	return ret
end
--行为树 Node 节点类
Node = class("Node",nil)

function Node:ctor(nodeName)
	self.nodeName = nodeName
	self.__objecttype__ = "behaviortreenode"
	self.executeResultFalse = false
	self.executeResultTrue = true
	self.executeResultActing = 2
	self.executeResultReacting = 3
	self.nodeResultStrTbl = {
		[self.executeResultFalse] = "False",
		[self.executeResultTrue] = "True",
		[self.executeResultActing] = "Acting",
		[self.executeResultReacting] = "Reacting",
	}
end

function Node:createNode(nodeName)
	return Node.new(nodeName)
end

function Node:refresh(unit)

end

function Node:execute(target, delta, deep)
	print("can't excute node without any ")
end

function Node:nodeResultToString(nodeResult)
	return self.nodeResultStrTbl[nodeResult]
end



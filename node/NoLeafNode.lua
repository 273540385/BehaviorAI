NoLeafNode = class("NoLeafNode",Node.new("noleafnode"))

function NoLeafNode:ctor(nodeName)
	self.nodeName = nodeName
	self.__objecttype__ = "noleafnode"
	self.children = {}
	self.currentActingNodeIndex = nil
end

function NoLeafNode:createNode(nodeName)
	return NoLeafNode.new(nodeName)
end


function NoLeafNode:refresh(unit)
	if(nil ~= self.currentActingNodeIndex)then
		if(nil ~= self.children[self.currentActingNodeIndex].refresh)then
			self.children[self.currentActingNodeIndex]:refresh(unit)   
		end
		
		self.currentActingNodeIndex = nil
	end
end

function NoLeafNode:addNode(childNode)
	table.insert(self.children, childNode)
end

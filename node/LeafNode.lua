LeafNode = class("LeafNode",Node.new("leafnode"))

function LeafNode:ctor(nodeName)
	self.nodeName = nodeName
	self.__objecttype__ = "leafnode"
end

function LeafNode:addChild(childNode)
	print("Can't add node to a leaf node")	
end
	
function LeafNode:createNode(nodeName)
	return LeafNode.new(nodeName)
end

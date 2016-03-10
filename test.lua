require "BehaviorConfig"






local t = false
function testTrue(targt, delta)
	print(tostring(true))
	return true
end

function testFalse(node, target)
	print(tostring(false))
	return false
end

function testActing(node, target)
	if(false == t)then
		t = true
		print("acting ==>>> begin")
		return 2
	else
		print("acting ==>>> end")
		return true
	end
end


local trueNode = ConditionNode:createNode("testTrue", testTrue)
local actingNode = ConditionNode:createNode("actingNode", testActing)
local falseNode = ConditionNode:createNode("testFalse", testFalse)
local sequenceNode = SequenceNode:createNode("sequenceNode")
local selectorNode = SelectorNode:createNode("selectorNode")
sequenceNode:addNode(trueNode)
sequenceNode:addNode(actingNode)
sequenceNode:addNode(falseNode)
selectorNode:addNode(sequenceNode)
selectorNode:addNode(falseNode)
selectorNode:addNode(falseNode)
selectorNode:execute(nil, nil, 1)
selectorNode:execute(nil, nil, 1)









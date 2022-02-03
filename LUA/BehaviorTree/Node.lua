
-- function Test()
--     MacroName = sj.get_define("__BehaviorTree_Name")
--     if MacroName == "Root" then
--         print (MacroName)
--     else
--         MacroName = _c("Name?")
--         print(MacroName)
--     end
-- end

BTNode = {};

local this = BTNode;

function this:New(Name, Type)
    local NewNode = {};
    setmetatable(NewNode, self);
    self.__index = self;
    NewNode.Parent = nil;
    NewNode.Type = Type;
    NewNode.Child = {};
    NewNode.Name = Name;
    return NewNode;
end

function this:AddNode(Node)
    local Index = #self.Child + 1;
    Node.Parent = self;
    self.Child[Index] = Node;
    return NewNode;
end

function this:ToString()

    local Parent = "Parent: ";
    if (self.Parent) then
        Parent = Parent .. self.Parent.Name;
    else
        Parent = Parent .. "null";
    end

    local Type = "Type: ";
    if (self.Type == _c("BT_ROOT")) then
        Type = Type .. "BT_ROOT";
    elseif (self.Type == _c("BT_SELECTOR")) then
        Type = Type .. "BT_SELECTOR";
    elseif (self.Type == _c("BT_SEQUENCE")) then
        Type = Type .. "BT_SEQUENCE";
    elseif (self.Type == _c("BT_TASK")) then
        Type = Type .. "BT_TASK";
    else
        Type = Type .. "null";
    end

    local Name = "Name: " .. self.Name;
    print("< " .. self.Name .. " >");
    print("" .. Parent .. "\n" .. Type);
    print("------------------------");
end


function CreateNode(Name, Type)
    return BTNode:New(Name, Type);
end

function AddNode(Parent, Node)
    return Parent:AddNode(Node);
end

function Print(Node)
    print(Node:ToString())
    for i,v in ipairs(Node.Child) do
        Print(v)
    end
end

function PrintTree(Node)
    
end
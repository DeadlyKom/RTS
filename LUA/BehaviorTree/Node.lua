
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

function Pack(Offset, Tree, Node, Parent)

    for i, Child in ipairs(Node.Child) do
        if     (Child.Type == _c("BT_TASK"))     then
            Tree[#Tree + 1] = 0;
        elseif (Child.Type == _c("BT_SELECTOR")) then
            Tree[#Tree + 1] = 1;
        elseif (Child.Type == _c("BT_SEQUENCE")) then
            Tree[#Tree + 1] = 2;
        else
            sj.error("not valid type");
        end
    end

    Offset[#Offset + 1] = #Tree + 1;
    Offset[#Offset + 1] = Parent;

end

function PackTree(Node)
    local OffsetPack = {};
    local TreePack = {};

    IndexParent = 0;

    Pack(OffsetPack, TreePack, Node, 0);

    print("------------------------");
    for i, Offset in ipairs(OffsetPack) do
        print("< " .. Offset .. " >");
    end
    print("------------------------");
    for i, Tree in ipairs(TreePack) do
        print("< " .. Tree .. " >");
    end
    print("------------------------");
    
end

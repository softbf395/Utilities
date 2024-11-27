local weapon = {}

-- Ensure the game is The Strongest Battlegrounds (UNUSED)
--=====if game.PlaceId ~= 10449761463 then=====--
 --=====   game.Players.LocalPlayer:Kick("Game is not The Strongest Battlegrounds. TSB custom weapons only work in The Strongest Battlegrounds.")======--
--=====end=====--

function weapon:Create(list)
    -- Validate the input list
    if not list or type(list) ~= "table" then
        error("Invalid parameter: Expected a table with move properties.")
    end

    -- Ensure required properties are provided
    local moveName = list.name or "Unnamed Move"
    local cooldown = list.cooldown or 5 -- Default cooldown
    local action = list.action or function() print(moveName .. " activated!") end
    local description = list.description or "No description provided."

    -- Internal cooldown tracking
    local onCooldown = false
   local move = {Tool=nil}
    -- Create the tool
    local moveTool = Instance.new("Tool")
    moveTool.Name = moveName
    moveTool.RequiresHandle = false
    moveTool.CanBeDropped = false
    move.Tool=moveTool

    -- Tool properties
    local ToolScript = Instance.new("LocalScript", moveTool)
    
        local cooldown = cooldown
        local onCooldown = false

        moveTool.Activated:Connect(function()
            if onCooldown then
                warn("Move is on cooldown!")
                return
            end

            -- Trigger action
            moveTool:FindFirstChild("Action"):Fire()

            -- Set cooldown
            onCooldown = true
            task.delay(cooldown, function()
                onCooldown = false
            end)
        end)
    

    -- Bind action to the tool
    local actionBindable = Instance.new("BindableEvent", moveTool)
    actionBindable.Name = "Action"
    actionBindable.Event:Connect(function()
        action()
    end)


    -- Equip the tool
    local player = game.Players.LocalPlayer
    moveTool.Parent = player.Backpack
    function move:SetCallback(callback)
        actionBindable.Event:DisconnectAll()
        actionBindable.Event:Connect(callback)
    end

    print("Custom move '" .. moveName .. "' created with a cooldown of " .. cooldown .. " seconds.")
    return move
end

return weapon

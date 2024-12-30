local utility = {}
local TycoonUI
local Element

function notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end

function utility.notif(title, desc)
    notif(title, desc)
end

function utility.ForElement(element)
    TycoonUI = game.Players.LocalPlayer.Character:FindFirstChild("TycoonUI")
    if not TycoonUI or not TycoonUI:FindFirstChild("TextLabel") then
        notif("Error:", "TycoonUI or TextLabel not found")
        return
    end
    if TycoonUI.TextLabel.Text == element then
        Element = element
        notif("Custom Element by:", "Aedaniss7")
    else
        notif("Error:", "Element Chosen is not: " .. element)
    end
end

function utility.Setup(info)
    if not info or not info.ElementName or not info.Color then
        notif("Error:", "Invalid info provided")
        return
    end
    TycoonUI = game.Players.LocalPlayer.Character:FindFirstChild("TycoonUI")
    if not TycoonUI or not TycoonUI:FindFirstChild("TextLabel") then
        notif("Error:", "TycoonUI or TextLabel not found")
        return
    end
    TycoonUI.TextLabel.Text = info.ElementName
    TycoonUI.TextLabel.TextColor3 = info.Color
end

function utility.SetupMoves(moves)
    if typeof(moves) ~= "table" then
        notif("Error:", "Invalid moves list")
        return
    end

    for i, move in ipairs(moves) do
        notif("Move " .. i .. " (" .. move.Base .. ")" .. " is ", move.Name)
    end

    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
    if not backpack then
        notif("Error:", "Backpack not found")
        return
    end

    backpack.ChildAdded:Connect(function(child)
        child:SetAttribute("CustomName", true)
            
    end)
    while wait() do
    for i, move in ipairs(moves) do
        for _, tool in ipairs(backpack:GetChildren()) do
                if tool.Name == move.Base and tool:GetAttribute("CustomName") then
                    tool.Name = move.Name
                end
                
            if tool.Name == move.Base and not tool:FindFirstChild("EventBoundMove") then
                tool:SetAttribute("CustomName", true)
                tool.Activated:Connect(function()
                    if typeof(move.Callback) == "function" and tool.Name==move.Name then
                        tool:SetAttribute("CustomName", false)
                        tool.Name = move.Base
                        move.Callback()
                                tool.Parent=backpack
                        wait(0.1)
                        
                        tool:SetAttribute("CustomName", true)
                    else
                        notif("Error:", "Invalid callback for move: " .. move.Name)
                    end
                end)
                Instance.new("BoolValue", tool).Name="EventBoundMove"
            end
        end
    end
    end
end

return utility

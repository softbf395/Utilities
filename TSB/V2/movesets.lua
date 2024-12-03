local utility = {}

function notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end

function utility:Ult(name, color, onActivation)
    if not color then
        notif("Error:", "Developer forgot to set color to 'no' or Color3.fromRGB(colorR,ColorG,ColorB)!")
        return
    end
    if not name then
        notif("Error:", "Developer forgot to set Ultimate's name!")
        return
    end
    
    local ultText = game.Players.LocalPlayer.PlayerGui.ScreenGui.MagicHealth.TextLabel
    local ultBar = ultText.Parent.Health.Bar.Fill
    ultText.Text = name
    ultBar.ImageColor3 = color
    if onActivation then
        ultBar.Parent.MouseButton1Click:Connect(function()
            local canUse = ultText.Parent.Ult.Visible
            if canUse then
                onActivation()
            end
        end)
    end
end

local hotbar = game.Players.LocalPlayer.PlayerGui.Hotbar.Backpack.Hotbar
local customCooldowns = { ["0"] = math.huge }

function customSlotCD(CD, MID)
    if not customCooldowns[tostring(MID)] then
        local move = hotbar[tostring(MID)].Base
        local cdf = Instance.new("Frame", hotbar[tostring(MID)].Base)
        cdf.Size = UDim2.new(1, 0, 1, 0)
        cdf.BackgroundColor3 = Color3.new(1, 0, 0)
        cdf.BackgroundTransparency = 0.6
        cdf.ZIndex = 10
        customCooldowns[tostring(MID)] = CD
        spawn(function()
            game:GetService("TweenService"):Create(cdf, TweenInfo.new(CD, Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0) }):Play()
            wait(CD)
            cdf:Destroy()
            customCooldowns[tostring(MID)] = nil
        end)
        return true
    else
        return false
    end
end

local tools = {}

function utility:ReqChr(ChrName)
    if ChrName == "Saitama" then
        tools = { "Normal Punch", "Consecutive Punches", "Shove", "Uppercut" }
    elseif ChrName == "Cyborg" then
        tools = { [1] = "Machine Gun Blows", [2] = "Ignition Burst", [3] = "Blitz Shot", [4] = "Jet Dive" }
    else
        notif("Error:", ChrName .. " is not in the list of current characters: Cyborg, Saitama")
    end
end

function utility:Create(MID, Callback, CD, MName)
    if tools[1] and type(tools[1]) == "string" then
        notif("Starting:", MName .. " Custom Moveset, uses Aedaniss7's custom movesets V2 utility")
        for i, moveName in ipairs(tools) do
            if not game.Players.LocalPlayer.Backpack:FindFirstChild(moveName) then
                notif("Error:", "Holding move " .. moveName .. " or aren't the character that has the move!")
                return
            end
            tools[i] = game.Players.LocalPlayer.Backpack[moveName]
        end
    else
        notif("Encountered Fatal Error:", ":ReqChr('character') has not been run! This is vital for setting up moves!")
        return
    end

    local moveSlot, err = pcall(function()
        return hotbar[tostring(MID)]
    end)
    if not moveSlot then
        notif("Error:", err)
        return
    end

    local isCustom = MID <= 4
    if isCustom then
        moveSlot.Base.MouseButton1Click:Connect(function()
            if customSlotCD(CD, MID) then
                Callback()
            end
        end)
        moveSlot.Base.ToolName.Text = MName
        moveSlot.Base.Reuse.Visible = false
        moveSlot.Visible = true
    else
        tools[MID].Activated:Connect(function()
            Callback()
        end)
        moveSlot.Base.ToolName.Text = MName
    end
end

function utility:SFX(music, url, path)
    if not isfile(path) then
        writefile(path, game:HttpGet(url))
        print(path .. " Saved!")
    else
        appendfile(path, game:HttpGet(url))
        print(path .. " Updated!")
    end
    local audioID = getcustomasset(path)
    local Sound = Instance.new("Sound", workspace)
    Sound.Looped = music
    Sound.SoundId = audioID
    return Sound
end

return utility

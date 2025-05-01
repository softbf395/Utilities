local utility = {}

local script="V3MTSB"

local hi=loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/Table.lua"))()


function notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end

if table.find(hi.EAScripts, script) then
  if not table.find(hi.Early, game.Players.LocalPlayer.Name) then
    notif("Notice!", "You do not have Early Access to script" ..script.."!")
    return
  end
end
if table.find(hi.Blacklisted, game.Players.LocalPlayer.Name) then
  notif("Notice!", "You are BLACKLISTED from using Aedaniss7's scripts!")
  return
end
notif("NOTICE:","i noticed avocado alien (@avocado_alien on yt) pressed activate ult during the TTM showcase, just to note: that will break custom ults")
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
    local ultBar = ultText.Parent.Health.Bar.Bar
    ultText.Text = name
    ultBar.ImageColor3 = color
    if onActivation then
        ultText.Parent.TextButton.MouseButton1Click:Connect(function()
            local canUse = ultText.Parent.Ult.Visible
            if canUse then
                onActivation()
            end
        end)
        game:GetService("UserInputService").InputBegan:Connect(function(i, t)
        if i.KeyCode==Enum.KeyCode.G and t==false then
          local canUse = ultText.Parent.Ult.Visible
            if canUse then
                onActivation()
            end
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
local chrName
function utility:ReqChr(ChrName)
    if ChrName == "Saitama" then
        chrName="Bald"
        tools = { "Normal Punch", "Consecutive Punches", "Shove", "Uppercut" }
    elseif ChrName == "Cyborg" then
        chrName="Cyborg"
        tools = { [1] = "Machine Gun Blows", [2] = "Ignition Burst", [3] = "Blitz Shot", [4] = "Jet Dive" }
    elseif ChrName == "Hunter" then
        chrName="Hunter"
        tools = { [1] = "Flowing Water", [2] = "Lethal Whirlwind Stream", [3] = "Hunter's Grasp", [4] = "Prey's Peril" }
    else
        notif("Error:", ChrName .. " is not in the list of current characters: Cyborg, Saitama, Hunter")
    end
end
function utility:Create(MID, Callback, CD, MName)
    if tools[1] and type(tools[1]) == "string" then
        notif("Starting:", MName .. " Custom Moveset, uses Aedaniss7's custom movesets V3 utility")
        for i, moveName in ipairs(tools) do
            if not game.Players.LocalPlayer.Backpack:FindFirstChild(moveName) then
                notif("Error:", "Holding move " .. moveName .. " or aren't the character that has the move!")
                return
            end
            tools[i] = game.Players.LocalPlayer.Backpack[moveName]
        end
    elseif not tools[1] then
        notif("Encountered Fatal Error:", ":ReqChr('character') has not been run! This is vital for setting up moves!")
        return
    end

    local success, moveSlot = pcall(function()
        return hotbar[tostring(MID)]
    end)
    if not success then
        notif("Error:", moveSlot)
        return
    end

    local isCustom = not hotbar[tostring(MID)].Visible
    if isCustom then
        local keybinds={
      [1]="One",
      [2]="Two",
      [3]="Three",
      [4]="Four",
      [5]="Five",
      [6]="Six",
      [7]="Seven",
      [8]="Eight",
      [9]="Nine"
    }
        
        game:GetService("UserInputService").InputBegan:Connect(function(i, t)
        if i.KeyCode==Enum.KeyCode[keybinds[MID]] then
          Callback()
        end
      end)
        hotbar[tostring(MID)].Base.MouseButton1Click:Connect(function()
            if customSlotCD(CD, MID) then
                Callback()
            end
        end)
        hotbar[tostring(MID)].Base.ToolName.Text = MName
        hotbar[tostring(MID)].Base.Reuse.Visible = false
        hotbar[tostring(MID)].Visible = true
    else
        local keybinds={
      [1]="One",
      [2]="Two",
      [3]="Three",
      [4]="Four",
      [5]="Five",
      [6]="Six",
      [7]="Seven",
      [8]="Eight",
      [9]="Nine"
    }
        --game.Players.LocalPlayer.Backpack[tools[MID]].Activated:Connect(Callback)
        game:GetService("UserInputService").InputBegan:Connect(function(i, t)
        if i.KeyCode==Enum.KeyCode[keybinds[MID]] then
          Callback()
        end
      end)
        hotbar[tostring(MID)].Base.MouseButton1Click:Connect(function()
            if customSlotCD(CD, MID) then
                Callback()
            end
        end)
        hotbar[tostring(MID)].Base.ToolName.Text = MName
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
local p=game.Players.LocalPlayer
function utility:ChrSel(name, icon, selNotice, callback)
    local bald=p.PlayerGui.TopbarPlus:FindFirstChild("Bald", true):Clone()
    bald.IconButton.IconLabel.Text=name
    local args = {
["Goal"] = "Change Character",
["Character"] = chrName
}

    if type(icon)=="number" then
        bald.IconButton.IconImage.Image="rbxassetid://"..icon
    else
        bald.IconButton.IconImage.Image=icon
    end
    bald.IconButton.MouseButton1Click:Connect(function()
            if selNotice~=nil then
                notif("NOTICE", selNotice)
            end
                game.Players.LocalPlayer.Character:WaitForChild("Communicate"):FireServer(args)
                p.Character:FindFirstChildOfClass("Humanoid").Health=0
                wait(5)
            hotbar = game.Players.LocalPlayer.PlayerGui.Hotbar.Backpack.Hotbar
            callback()
            end)
        callback()
    bald.Parent=p.PlayerGui.TopbarPlus:FindFirstChild("Bald", true).Parent
    end
function utility:Bind(Animation, Callback)
    p.Character.Humanoid.Animator.AnimationPlayed:Connect(function(animTrack)
            if animTrack.Animation.AnimationId==Animation then
                Callback(animTrack)
            end
    end)
end
return utility

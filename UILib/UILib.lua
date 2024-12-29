local UILib = {}
local SavePath = nil
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- File handling for images
local function GetCustomAsset(url)
    local fileName = "uilib/" .. url:match("[^/]+$") -- Extract the file name from URL
    if not isfile(fileName) then
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success then
            writefile(fileName, result)
        else
            warn("Failed to download asset from URL: " .. url)
            return nil
        end
    end
    return getsynasset(fileName) or getcustomasset(fileName)
end

-- Save Path Setter
function UILib:SetSavePath(path)
    SavePath = path
    if not isfile(SavePath) then
        writefile(SavePath, "{}") -- Create a default save file if it doesn't exist
    end
end

-- Save Data
function UILib:SaveData(data)
    if SavePath then
        writefile(SavePath, HttpService:JSONEncode(data))
    else
        warn("Save path not set. Call SetSavePath first.")
    end
end

-- Load Data
function UILib:LoadData()
    if SavePath and isfile(SavePath) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(SavePath))
        end)
        if success then
            return result
        else
            warn("Failed to load data from save file: " .. result)
        end
    end
    return {}
end

-- Intro Animation with Credit to Aedaniss7
function UILib:ShowIntro(config)
    local introFrame = Instance.new("Frame")
    introFrame.Size = UDim2.new(1, 0, 1, 0)
    introFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    introFrame.Parent = CoreGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = config.Title or "Welcome"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 36
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0.4, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = introFrame

    local descLabel = Instance.new("TextLabel")
    descLabel.Text = config.Description or "Loading..."
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 24
    descLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    descLabel.Size = UDim2.new(1, 0, 0.05, 0)
    descLabel.Position = UDim2.new(0, 0, 0.5, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Parent = introFrame

    if config.Image then
        local introImage = Instance.new("ImageLabel")
        introImage.Image = GetCustomAsset(config.Image) or ""
        introImage.Size = UDim2.new(0, 150, 0, 150)
        introImage.Position = UDim2.new(0.5, -75, 0.2, 0)
        introImage.BackgroundTransparency = 1
        introImage.Parent = introFrame
    end

    -- Credit Label for Creator
    local creditLabel = Instance.new("TextLabel")
    creditLabel.Text = "UILib used Created by Aedaniss7"
    creditLabel.Font = Enum.Font.Gotham
    creditLabel.TextSize = 18
    creditLabel.TextColor3 = Color3.new(1, 1, 1)
    creditLabel.Size = UDim2.new(1, 0, 0.05, 0)
    creditLabel.Position = UDim2.new(0, 0, 0.85, 0)
    creditLabel.BackgroundTransparency = 1
    creditLabel.TextXAlignment = Enum.TextXAlignment.Center
    creditLabel.Parent = introFrame

    wait(config.Duration or 3)

    introFrame:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 1, true, function()
        introFrame:Destroy()
    end)
end


-- Create a Panel
function UILib:CreatePanel(title, icon)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0.3, 0, 0.5, 0)
    panel.Position = UDim2.new(0.35, 0, 0.25, 0)
    panel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    panel.BorderSizePixel = 0
    panel.Parent = CoreGui

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0.1, 0)
    titleBar.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = panel

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 20
    closeButton.TextColor3 = Color3.new(1, 0, 0)
    closeButton.Size = UDim2.new(0.2, 0, 1, 0)
    closeButton.Position = UDim2.new(0.8, 0, 0, 0)
    closeButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    closeButton.BorderSizePixel = 0
    closeButton.Parent = titleBar

    closeButton.MouseButton1Click:Connect(function()
        panel:Destroy()
    end)

    -- Draggable functionality
    local dragging, dragInput, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return {
        AddTab = function(tabTitle, tabIcon)
            -- Logic for tabs
        end
    }
end

return UILib

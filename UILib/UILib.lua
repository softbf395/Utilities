-- UILib Module
local UILib = {}

-- Create Panel Function
function UILib:CreatePanel(properties)
    local panel = Instance.new("Frame", Instance.new("ScreenGui", game.CoreGui))
    panel.Name = properties.Title
    panel.Size = properties.Size or UDim2.new(0, 400, 0, 500)
    panel.Position = properties.Position or UDim2.new(0, 50, 0, 50)
    panel.BackgroundColor3 = properties.BackgroundColor or Color3.fromRGB(30, 30, 30)
    panel.BorderSizePixel = 0
    panel.Visible = true

    -- Add title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleLabel.Text = properties.Title or "Panel"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = panel

    -- Make panel draggable
    if properties.Draggable then
        local dragInput, dragStart, startPos
        panel.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragStart = input.Position
                startPos = panel.Position
                dragInput = input
            end
        end)

        panel.InputChanged:Connect(function(input)
            if dragInput and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        panel.InputEnded:Connect(function(input)
            if input == dragInput then
                dragInput = nil
            end
        end)
    end

    return panel
end

-- Create Tab Function
function UILib:CreateTab(properties)
    local tab = Instance.new("Frame")
    tab.Name = properties.Title
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = true

    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 120, 0, 30)
    tabButton.Position = UDim2.new(0, 0, 0, 30)
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabButton.Text = properties.Title or "Tab"
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.Parent = tab

    -- Tab button click functionality
    tabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(tab.Parent:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        tab.Visible = true
    end)

    tab.Parent = properties.Panel
    return tab
end

-- Create Section Function
function UILib:CreateSection(properties)
    local section = Instance.new("Frame")
    section.Name = properties.Title
    section.Size = UDim2.new(1, 0, 0, properties.SizeY or 50)
    section.Position = properties.Position or UDim2.new(0, 0, 0, 60)
    section.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    section.BorderSizePixel = 0
    section.Visible = true
    section.Parent = properties.Tab

    -- Section Title
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, 0, 0, 20)
    sectionTitle.Text = properties.Title
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextSize = 14
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section

    -- Add methods to Section to handle different UI elements
    section.AddButton = function(info)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 30)
        button.Position = UDim2.new(0, 0, 0, 25)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.Text = info.Title
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.MouseButton1Click:Connect(info.Callback)
        button.Parent = section
    end

    section.AddToggle = function(info)
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0, 50, 0, 30)
        toggle.Position = UDim2.new(0, 0, 0, 25)
        toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        toggle.Text = info.Default and "ON" or "OFF"
        toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggle.Font = Enum.Font.GothamBold
        toggle.TextSize = 14
        toggle.MouseButton1Click:Connect(function()
            local newState = toggle.Text == "OFF"
            toggle.Text = newState and "ON" or "OFF"
            info.Callback(newState)
        end)
        toggle.Parent = section
    end

    section.AddSlider = function(info)
        local slider = Instance.new("Frame")
        slider.Size = UDim2.new(1, 0, 0, 30)
        slider.Position = UDim2.new(0, 0, 0, 25)
        slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        slider.Parent = section
        
        local sliderButton = Instance.new("TextButton")
        sliderButton.Size = UDim2.new(0, 100, 0, 20)
        sliderButton.Position = UDim2.new(0.5, -50, 0, 5)
        sliderButton.Text = tostring(info.Default)
        sliderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        sliderButton.Font = Enum.Font.GothamBold
        sliderButton.TextSize = 14
        sliderButton.Parent = slider

        sliderButton.MouseButton1Click:Connect(function()
            local value = sliderButton.Position.X.Offset / slider.Size.X.Offset * (info.Max - info.Min) + info.Min
            info.Callback(value)
            sliderButton.Text = tostring(value)
        end)
    end

    section.AddNumberInput = function(info)
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(1, 0, 0, 30)
        input.Position = UDim2.new(0, 0, 0, 25)
        input.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        input.Text = tostring(info.Default)
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        input.Font = Enum.Font.GothamBold
        input.TextSize = 14
        input.Parent = section
        input.FocusLost:Connect(function()
            info.Callback(tonumber(input.Text))
        end)
    end

    section.AddStringInput = function(info)
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(1, 0, 0, 30)
        input.Position = UDim2.new(0, 0, 0, 25)
        input.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        input.Text = info.Default
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        input.Font = Enum.Font.GothamBold
        input.TextSize = 14
        input.Parent = section
        input.FocusLost:Connect(function()
            info.Callback(input.Text)
        end)
    end

    return section
end

-- Show Intro Function
function UILib:ShowIntro(properties)
    -- Create intro UI (omitted for simplicity)
end

-- Export UILib
return UILib

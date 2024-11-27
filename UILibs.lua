local libUI = {}

function libUI:AddWindow(list)
    local winName = list.name
    local LibCredits = list.UICreditsEnabled
    local winCreditsCustom = list.CustomCredits

    local window = {}
    window.Instance = Instance.new("Frame", Instance.new("ScreenGui", game.CoreGui))
    local Frame = window.Instance
    Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Frame.Size = UDim2.new(1, 0, 1, 0)
    
    -- Exit Button
    local exit = Instance.new("TextButton", Frame)
    exit.TextScaled = true
    exit.BackgroundTransparency = 1
    exit.TextColor3 = Color3.new(1, 0, 0)
    exit.Text = "EXIT GUI"
    exit.Name = "Exit"
    exit.Size = UDim2.new(0.1, 0, 0.05, 0)
    exit.Position = UDim2.new(0.9, -5, 0, 5)
    exit.MouseButton1Click:Connect(function()
        Frame:Destroy()
    end)

    -- Scrolling Frame
    local sf = Instance.new("ScrollingFrame", Frame)
    sf.CanvasSize = UDim2.new(0, 0, 100, 0)
    sf.Size = UDim2.new(1, 0, 0.8, 0)
    sf.Position = UDim2.new(0, 0, 0.2, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 10

    -- List Layout
    local ListLayout = Instance.new("UIListLayout", sf)

    -- Function to add tabs to the UI
    function window:AddTab(tabInfo)
        local Tab = {}

        local TabButton = Instance.new("TextButton", sf)
        TabButton.Text = tabInfo.name or "Tab Name"
        TabButton.TextScaled = true
        TabButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        TabButton.TextColor3 = Color3.new(1, 1, 1)
        TabButton.Size=UDim2.new(1,0,0,50)
        TabButton.BorderSizePixel = 0
        local Buttonscroll=Instance.new("ScrollingFrame", sf)
        Buttonscroll.BackgroundTransparency=1
        Buttonscroll.CanvasSize=UDim2.new(0,0,100,0)
        Buttonscroll.Size=UDim2.new(1,0,0,400)
        ListLayout:Clone().Parent=Buttonscroll
        local sf2open=true
        TabButton.MouseButton1Click:Connect(function()
          if sf2open==true then
            Buttonscroll.Size=UDim2.new(1,0,0,0) -- no order change!
            sf2open=false
          else
            Buttonscroll.Size=UDim2.new(1,0,0,400)
              sf2open=true
            end
          end)
        function Tab:AddButton(list)
             
            local button={Instance=Instance.new("TextButton",Buttonscroll)}
            local Button=button.Instance
        Button.Text = list.name or "Button Name"
        Button.TextScaled = true
        Button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.Size=UDim2.new(1,0,0,50)
        Button.BorderSizePixel = 0
       Button.MouseButton1Click:Connect(list.Callback or function() end)
          function  button:SetCallback(Callback)
              Button.MouseButton1Click:Connect(Callback)
          end
        return button
        end

        return Tab
    end

    -- Optional: Add credits if enabled
    if LibCredits then
        local creditsLabel = Instance.new("TextLabel", Frame)
        creditsLabel.Size = UDim2.new(1, 0, 0.1, 0)
        creditsLabel.Position = UDim2.new(0, 0, 0.9, 0)
        creditsLabel.BackgroundTransparency = 1
        creditsLabel.TextScaled = true
        creditsLabel.TextColor3 = Color3.new(1, 1, 1)
        creditsLabel.Text = winCreditsCustom or "UI created using libUI by Aedaniss7"
    end

    return window
end

return libUI

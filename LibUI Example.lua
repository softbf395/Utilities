-- Load your libUI module
local libUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/UILibs.lua"))()

-- Create a new window
local myWindow = libUI:AddWindow({
    name = "Example GUI",
    UICreditsEnabled = true,
    -- CustomCredits = "Created by Aedaniss7"
})

-- Add a tab to the window
local myTab = myWindow:AddTab({
    name = "Main Tab"
})

-- Add buttons to the tab
local button1 = myTab:AddButton({
    name = "Print Hello",
    Callback = function()
        print("Hello, world!")
    end
})

local button2 = myTab:AddButton({
    name = "Change Color",
    Callback = function()
        myWindow.Instance.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
    end
})

-- Add another tab
local anotherTab = myWindow:AddTab({
    name = "Another Tab"
})

-- Add a button to the new tab
local button3 = anotherTab:AddButton({
    name = "Goodbye",
    Callback = function()
        print("Goodbye, world!")
    end
})
button1:SetCallback(function()
print("Hi! World")
end)

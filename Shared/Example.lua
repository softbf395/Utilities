-- Load the shared utility script
local shareUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/Shared/sourceVTest.lua"))()

-- The string containing the script to be shared
local scriptToShare = [[
-- Settings
local animationId = "rbxassetid://77727115892579" -- Animation ID to trigger the video
local videoFile = "JKUFW.mp4"
local videoUrl = "https://raw.githubusercontent.com/softbf395/JK-unlimitedReskin/refs/heads/main/JK.mp4"

-- Services
local players = game:GetService("Players")

local function stopAllSounds()
    task.wait(1)
    for _, instance in ipairs(game:GetDescendants()) do
        if instance:IsA("Sound") then
            instance.Playing = false
        end
    end
end

local function setup(humanoid)
    if humanoid then
        humanoid.Animator.AnimationPlayed:Connect(function(animTrack)
            if animTrack.Animation and animTrack.Animation.AnimationId == animationId then
                stopAllSounds()

                local screenGui = Instance.new("ScreenGui")
                screenGui.IgnoreGuiInset = true
                screenGui.ScreenInsets = Enum.ScreenInsets.None
                screenGui.DisplayOrder = 9999
                screenGui.Parent = players.LocalPlayer:WaitForChild("PlayerGui")

                local videoFrame = Instance.new("Frame", screenGui)
                videoFrame.Size = UDim2.new(1, 0, 1, 0)
                videoFrame.BackgroundTransparency = 1

                local video = Instance.new("VideoFrame", videoFrame)
                video.Size = UDim2.new(1, 0, 1, 0)
                video.BackgroundTransparency = 1
                video.Video = getcustomasset(videoFile)

                videoFrame.Visible = true
                video.Visible = true
                video:Play()

                video.Ended:Connect(function()
                    screenGui:Destroy()
                end)
            end
        end)
    end
end

local function init()
    local player = players.LocalPlayer
    if not isfile(videoFile) then
        local screenGui = Instance.new("ScreenGui")
        screenGui.IgnoreGuiInset = true
        screenGui.ScreenInsets = Enum.ScreenInsets.None
        screenGui.ResetOnSpawn = false
        screenGui.DisplayOrder = 9999
        screenGui.Parent = player:WaitForChild("PlayerGui")

        local loadingText = Instance.new("TextLabel", screenGui)
        loadingText.Size = UDim2.new(0.3, 0, 0.1, 0)
        loadingText.Position = UDim2.new(0.35, 0, 0.45, 0)
        loadingText.BackgroundTransparency = 1
        loadingText.TextScaled = true
        loadingText.TextColor3 = Color3.new(1, 1, 1)
        loadingText.Font = Enum.Font.SourceSansBold
        loadingText.Text = "Downloading Video..."
        loadingText.Visible = true

        writefile(videoFile, game:HttpGet(videoUrl))

        loadingText.Text = "Download Complete!"
        task.wait(1.5)
        screenGui:Destroy()
    end

    if player.Character then
        setup(player.Character:FindFirstChildOfClass("Humanoid"))
    end

    player.CharacterAdded:Connect(function(character)
        setup(character:FindFirstChildOfClass("Humanoid"))
    end)
end
init()]]

-- Use the utility to share and run the script
shareUtil.BroadcastScript(scriptToShare, game.Players.LocalPlayer.Name)

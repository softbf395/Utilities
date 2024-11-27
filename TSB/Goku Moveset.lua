local weapon = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/Custom%20Weapon.lua"))()

-- Remove existing moves (optional)
for _, move in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
  move:Destroy()
end

-- Create Kamehameha move
local Kamehameha = weapon:Create({
  name = "Kamehameha",
  cooldown = 10,
  action = function()
    -- Play Kamehameha animation
    local character = game.Players.LocalPlayer.Character

    -- Create energy ball effect at character's hand
    local energyBall = Instance.new("Part")
    energyBall.Shape = Enum.PartType.Ball
    energyBall.Size = Vector3.new(0.5, 0.5, 0.5)
    local lookVector = character.HumanoidRootPart.CFrame.LookVector
    local offset = 2 -- Adjust this value to control the distance
    
    energyBall.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(lookVector.X * offset, lookVector.Y * offset, lookVector.Z * offset)
    energyBall.Transparency = 0.7
    energyBall.Color = Color3.new(0,1,1)
    energyBall.Parent = workspace

    -- Move the energy ball towards the target
    local targetPos = game.Players.LocalPlayer:GetMouse().Hit.Position
    local direction = (targetPos - energyBall.Position).Unit
    local speed = 50

    while energyBall and energyBall.Parent do
      energyBall.CFrame = energyBall.CFrame + direction * speed * workspace.deltaTime
      task.wait()
    end

    energyBall:Destroy()
  end
})


-- Create Instant Transmission move
local InstantTransmission = weapon:Create({
  name = "Instant Transmission",
  cooldown = 5,
  action = function()
    -- Teleport to the target location
    local targetPos = game.Players.LocalPlayer:GetMouse().Hit.Position
    game.Players.LocalPlayer.Character:PivotTo(targetPos)
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPos))

    
  end
})

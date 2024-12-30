local utility = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/EPT/Custom%20element/source.lua"))()

-- Define the custom element information
utility.ForElement("Ice") -- Check if the current element is "Ice"
utility.Setup({
    ElementName = "Rebirth",
    Color = Color3.fromRGB(255, 0, 255) -- Gold-like color for "Rebirth"
})

-- Define custom moves for the "Rebirth" element
utility.SetupMoves({
    {
        Base = "Ice Disk",
        Name = "Phoenix Shard",
        Callback = function()
            -- Example effect: Spawn a reborn flame projectile
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local flame = Instance.new("Part", workspace)
            flame.Name = "PhoenixFlame"
            flame.Size = Vector3.new(2, 2, 2)
            flame.BrickColor = BrickColor.new("Bright yellow")
            flame.Material = Enum.Material.Neon
            flame.Position = char.Head.Position + Vector3.new(0, 5, 0)
            flame.Velocity = char.Head.CFrame.LookVector * 50
            game:GetService("Debris"):AddItem(flame, 5)
        end
    },
    {
        Base = "Ultracold Aura",
        Name = "Rebirth Barrier",
        Callback = function()
            -- Example effect: Spawn a barrier in front of the player
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local barrier = Instance.new("Part", workspace)
            barrier.Name = "RebirthBarrier"
            barrier.Size = Vector3.new(10, 10, 1)
            barrier.BrickColor = BrickColor.new("Bright yellow")
            barrier.Material = Enum.Material.Neon
            barrier.CFrame = char.Head.CFrame + char.Head.CFrame.LookVector * 5
            barrier.Anchored = true
            game:GetService("Debris"):AddItem(barrier, 10)
        end
    },
    {
        Base = "Frost Fire Ball",
        Name = "Rebirth Beam",
        Callback = function()
            -- Example effect: Damage enemies and heal allies in a line
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local beam = Instance.new("Part", workspace)
            beam.Name = "RebirthBeam"
            beam.Size = Vector3.new(1, 1, 50)
            beam.BrickColor = BrickColor.new("Bright yellow")
            beam.Material = Enum.Material.Neon
            beam.CFrame = char.Head.CFrame + char.Head.CFrame.LookVector * 25
            beam.Anchored = true
            game:GetService("Debris"):AddItem(beam, 2)
            -- Apply effects to nearby players (mocked example)
        end
    }
})

local weapon = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/Custom%20Weapon.lua"))()
-- remove all moves
for _, move in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
  move:Destroy()
end
if not isfile("music/TSB/megalovania.mp3") then
    writefile("music/TSB/megalovania.mp3", game:HttpGet("https://raw.githubusercontent.com/softbf395/tsbmoveassets/refs/heads/main/sans.mp3"))
end
local Music=getcustomasset("music/TSB/megalovania.mp3")
local SoundMusic=Instance.new("Sound", workspace)
SoundMusic.SoundId=Music
SoundMusic.Volume=1.5
SoundMusic.Looped=true
SoundMusic:Play()
-- Create a move
local GasterBlaster = weapon:Create({
    name = "Gaster Blaster";
    cooldown = 3;
    action = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local mouse = player:GetMouse()

        -- Position 3 studs above the player's head
        local startPos = (character.Head.CFrame * CFrame.new(0, 3, 0)).Position
        local endPos = mouse.Hit.Position

        -- Calculate direction and length
        local direction = (endPos - startPos).Unit
        local distance = (endPos - startPos).Magnitude
        local sizeY =  (startPos - endPos).Magnitude

        -- Create the beam as a neon cylinder
        local beam = Instance.new("Part")
        beam.Shape = Enum.PartType.Cylinder
        beam.Size = Vector3.new(0.5, sizeY, 0.5) -- Adjust width (X, Z) and length (Y)
        beam.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.pi / 2, 0)
        beam.Anchored = true
        beam.CanCollide = false
        beam.Material = Enum.Material.Neon
        beam.BrickColor = BrickColor.new("Institutional white")
        beam.Parent = workspace

        -- Clean up the beam after a short delay
        game:GetService("Debris"):AddItem(beam, 0.5)
    end})

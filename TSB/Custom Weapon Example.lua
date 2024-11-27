local weapon = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/Custom%20Weapon.lua"))()
-- remove all moves
for _, move in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
  move:Destroy()
end
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

-- Create a move
local Weapon1 = weapon:Create({
    name = "Example";
    cooldown = 3;
    action = function()
        local mouse=game.Players.LocalPlayer:GetMouse()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Position=mouse.Hit.Position+Vector3.new(0,2,0)
    end
})

-- Modify the action later
--flameSlash:SetCallback(function()
--    print("Flame Slash redefined! New action triggered!")
--end)

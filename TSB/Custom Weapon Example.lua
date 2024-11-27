local weapon = loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/Custom%20Weapon.lua"))()
-- remove all moves
for _, move in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
  move:Destroy()
end

-- Create a move
local Weapon1 = weapon:Create({
    name = "Example";
    cooldown = 3;
    action = function()
        local mouse=game.Players.LocalPlayer:GetMouse()
        game.Players.LocalPlayer.Character:PivotTo(mouse.Hit)
    end
})

-- Modify the action later
--flameSlash:SetCallback(function()
--    print("Flame Slash redefined! New action triggered!")
--end)

local utility = {}
local TycoonUI
local Element
function notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end
function utility.notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end
function utility.ForElement(element)
  TycoonUI = game.Players.LocalPlayer.Character.TycoonUI
  if TycoonUI.TextLabel.Text == element then
    Element=element
    notif("Custom Element by:","Aedaniss7")
  else
    notif("Error:","Element Chosen is not: "..element)
  end
end
function utility.Setup(info)
  TycoonUI.TextLabel.Text=info.ElementName
  TycoonUI.TextLabel.TextColor3=info.Color
end
function utility.SetupMoves(moves)
  for i, move in ipairs(moves) do
    notif("Move "..i.." is "..move.Name)
  end
  while wait() do
    for i, move in ipairs(moves) do
      wait()
      for _, tool in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        wait()
        if tool.Name==move.Base then
          tool.Name=move.Name
          tool.Activated:Connect(move.Callback)
        end
      end
    end
  end
end
return utility

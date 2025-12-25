local Moveset="T"
function notif(title, desc)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = title or "Error", Text = desc or "Error" })
end
local ms=loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/PBG/V1/MovesetUtil.lua"))()
--local SFXM1=ms:SFX(false, "url", "path")
--local SFXM2=ms:SFX(false, "url", "path")
--local SFXM3=ms:SFX(false, "url", "path")
--local SFXM4=ms:SFX(false, "url", "path")
local music=Instance.new("Sound")
music.SoundId="rbxassetid://106404453382983"
music:Play()
music.Parent=game.Players.LocalPlayer.Character
music.Volume=6
notif("Downloading:", "Rotteen - Don't Keep Me a Secret (music/PBG/ult/DontKeepSecret.mp3)")
local awkMus=ms:SFX(true, "https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/PBG/V1/DontKeepSecret.mp3","music/PBG/ult/DontKeepSecret.mp3")
notif("Downloading:","Complete! Starting moveset:")
awkMus.Playing=false

ms:ReqChr("Gravity" --[[Cyborg]])
ms:Ult("Soundbreaking Roar", Color3.fromRGB(191, 67, 67), function() print("Ult Activated!") end)
ms:Create("1", function() 


end, 0, "Roar")
local roar=Instance.new("Sound")
roar.SoundId="rbxassetid://"..6729434602
roar.Volume=10
roar.Parent=workspace
function impact(times,Spikes)
	local chr = game.Players.LocalPlayer.Character
	local origin=chr.Head.Position
	local isDark=false
	local cc=Instance.new("ColorCorrectionEffect",game.Lighting)
	cc.Brightness=10000
	cc.Enabled=true
	local hl=Instance.new("Highlight",chr)
	hl.Enabled=true
	hl.FillColor=Color3.new(0,0,0)
	hl.OutlineTransparency=1
	hl.FillTransparency=0
	local SpikeFold=Instance.new("Folder",chr)
	SpikeFold.Name="ImpactFrames"
	for i=1, times do 
		for i=1,Spikes do 
			local spike=Instance.new("Part",chr)
			spike.Anchored=true
			local Z=math.random(5,100)
			spike.CanCollide=false
			spike.Size=Vector3.new(0.2,0.2,Z)
			local OutPosTypeX=math.random(1,2)
			local OutPosTypeY=math.random(1,2)
			local OutPosTypeZ=math.random(1,2)
			local OutPos=Vector3.new(0,0,0)
			local OutPosLook=Vector3.new(0,0,0)
			if OutPosTypeX==1 then
				OutPosLook-=Vector3.new(Z,0,0)
			else 
				OutPosLook+=Vector3.new(Z,0,0)
			end
			if OutPosTypeY==1 then
				OutPosLook-=Vector3.new(0,Z,0)
			else 
				OutPosLook+=Vector3.new(0,Z,0)
			end
			if OutPosTypeZ==1 then
				OutPosLook-=Vector3.new(0,0,Z)
			else 
				OutPosLook+=Vector3.new(0,0,Z)
			end
			local OutPos=Vector3.new(0,0,0)
			if OutPosTypeX==1 then
				OutPos-=Vector3.new(Z/2,0,0)
			else 
				OutPos+=Vector3.new(Z/2,0,0)
			end
			if OutPosTypeY==1 then
				OutPos-=Vector3.new(0,Z/2,0)
			else 
				OutPos+=Vector3.new(0,Z/2,0)
			end
			if OutPosTypeZ==1 then
				OutPos-=Vector3.new(0,0,Z/2)
			else 
				OutPos+=Vector3.new(0,0,Z/2)
			end
			spike.CFrame=CFrame.new(origin+OutPos+Vector3.new(math.random(-13,13),math.random(-13,13),math.random(-13,13)),origin+OutPosLook)
			spike.Parent=SpikeFold
		end
		if isDark==false then
			isDark=true
			cc.Brightness=10000
			hl.FillColor=Color3.new(0,0,0)
		else 
			isDark=false
			cc.Brightness=-10000
			hl.FillColor=Color3.new(1,1,1)
		end
		task.wait(1/15)
		SpikeFold:ClearAllChildren()
	end
	cc:Destroy()
	SpikeFold:Destroy()
	hl:Destroy()
end
ms:Bind(101713372022811, function(anim)
	anim:Stop()
	ms:plAn(75354915,3)
	task.wait(1/3)
	roar:Play()
	impact(5,30)
end)
game.Players.LocalPlayer.Character.DescendantAdded:Connect(function(de)
	if de.Name=="Awk" then
		music:Stop()
		de.Volume=6
		de.SoundId=awkMus.SoundId
		de.Destroying:Connect(function()
			music:Play()
		end)
	end
end)

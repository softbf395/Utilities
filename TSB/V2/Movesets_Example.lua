local ms=loadstring(game:HttpGet("https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/V2/movesets.lua"))()
--local SFXM1=ms:SFX(false, "url", "path")
--local SFXM2=ms:SFX(false, "url", "path")
--local SFXM3=ms:SFX(false, "url", "path")
--local SFXM4=ms:SFX(false, "url", "path")
local music=ms:SFX(true, "https://raw.githubusercontent.com/softbf395/Utilities/refs/heads/main/TSB/V2/NoCopyrightSounds%20-%20Boom%20Kitty%20%26%20Waterflame%20-%20Citadel%20Bass%20House%20NCS%20-%20Copyright%20Free%20Music.mp3", "music/TSB/Template")
music:Play()
ms:ReqChr("Saitama" --[[Cyborg]])
ms:Create(5, --[[move ID, 1 to 15]] function() end, --[[Callback for when used]] 2, --[[Cooldown for custom moves]] "Move Name")
ms:Ult("Ult Name", Color3.fromRGB(255,255,255), function print("Ult Activated!") end)

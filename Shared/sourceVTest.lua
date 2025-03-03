local websocket = websocket or error("WebSockets not supported!")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedScriptsUtil = {}

-- Unique JobID for server isolation
local JobID = game.JobId
local ServerURL = "wss://shared-script-websocket.glitch.me"  -- Your Glitch WebSocket URL

-- Store executed scripts
local ExecutedScripts = {}

-- WebSocket connection
local ws = websocket.connect(ServerURL)

-- Create SeenScripts in ReplicatedStorage if it doesn't exist
if not ReplicatedStorage:FindFirstChild("SeenScripts") then
    local folder = Instance.new("Folder")
    folder.Name = "SeenScripts"
    folder.Parent = ReplicatedStorage
end

local SeenScripts = ReplicatedStorage.SeenScripts

-- Utility: Replace 'LocalPlayer' with the player's username
local function replaceLocalPlayer(scriptStr, username)
    return scriptStr:gsub("LocalPlayer", username)
end

-- WebSocket receive event
ws.OnMessage:Connect(function(msg)
    local data = HttpService:JSONDecode(msg)

    if data.job ~= JobID then return end -- Ignore messages from other servers

    if data.type == "run" then
        local scriptID = data.username .. data.uuid  -- Unique script identifier

        -- Check if this script has already been seen
        if SeenScripts:FindFirstChild(scriptID) then return end

        -- Mark as seen
        local seenTag = Instance.new("StringValue")
        seenTag.Name = scriptID
        seenTag.Parent = SeenScripts

        -- Store executed script for later visibility
        table.insert(ExecutedScripts, { script = data.script, username = data.username, uuid = data.uuid })

        -- Notify player about the script execution
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Shared Script",
                Text = data.username .. " executed a script!",
                Duration = 5
            })
        end)

        -- Execute received script
        loadstring(replaceLocalPlayer(data.script, data.username))()
    elseif data.type == "request_history" then
        -- Send executed script history to the requesting executor
        ws:Send(HttpService:JSONEncode({
            type = "history",
            job = JobID,
            scripts = ExecutedScripts
        }))
    elseif data.type == "history" then
        -- Display history of executed scripts, skipping seen ones
        for _, scriptData in ipairs(data.scripts) do
            local scriptID = scriptData.username .. scriptData.uuid
            if not SeenScripts:FindFirstChild(scriptID) then
                print("Past script from " .. scriptData.username .. ": " .. scriptData.script)
                -- Mark as seen
                local seenTag = Instance.new("StringValue")
                seenTag.Name = scriptID
                seenTag.Parent = SeenScripts
            end
        end
    end
end)

-- Public function: Broadcast a script to all executors in the same JobID
function SharedScriptsUtil.BroadcastScript(script, username)
    local maxTraffic = 100 -- Limit (adjust as needed)
    
    if #ExecutedScripts >= maxTraffic then
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Server Busy",
                Text = "Too much traffic. Try again later.",
                Duration = 5
            })
        end)
        return
    end

    local uuid = HttpService:GenerateGUID(false)  -- Generate a unique script ID
    script = replaceLocalPlayer(script, username)

    -- Store script for visibility
    table.insert(ExecutedScripts, { script = script, username = username, uuid = uuid })

    -- Send script execution request via WebSocket
    ws:Send(HttpService:JSONEncode({
        type = "run",
        job = JobID,
        script = script,
        username = username,
        uuid = uuid
    }))
end

-- Public function: Request script execution history
function SharedScriptsUtil.RequestHistory()
    ws:Send(HttpService:JSONEncode({
        type = "request_history",
        job = JobID
    }))
end

return SharedScriptsUtil

--[[ // This was a script i made to fuck with perm users on khols admin house.
it's not as affective anymore as roblox's report system bacame less shitty

PS: if you actually use this in 2023 you're a sad person
]]

--return
repeat task.wait() until game:IsLoaded();

local game = game; 
local players = game:FindService("Players")
local StarterGui = game:FindService("StarterGui")
local HttpService = game:FindService("HttpService")
local TeleportService = game:FindService("TeleportService")

local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local lp = players.LocalPlayer
local cock = balls

local kicked = {}
--// whitelisted perm buyers
local whitelist = {
    "Leghat4445t",
    "sneakcal264",
    "siyamicik",
    "me_capybara",
    "lmaogang020a1",
    "whatjggotdeleted",
    "BANNter_Original"
}

StarterGui:SetCore("DevConsoleVisible", true)

if syn then error("Synapse has patched the functions used in this script therefore this script will not run.") return end

if writefile then
    if not isfile("plog.txt") then
        writefile("plog.txt", "Perm Player log: \n")
    end 
end

workspace.FallenPartsDestroyHeight = 0/0

coroutine.wrap(function()
    while task.wait() do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(1000000, 1000000, 1000000)
    end
end)()

print([[

    

    Sending kick requests:

]])

coroutine.wrap(function()
    if syn == nil then
      players.PlayerAdded:Connect(function(v)
          if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/"..v.UserId.."/items/GamePass/".. 66254), 66254) and not table.find(whitelist, v.name) then
              game.Players:ReportAbuse(v, "Cheating/Exploiting", "They keep spamming the chat using exploits. " .. math.random(1, 3e7))
              print("Kick request sent to " .. v.Name)
              table.insert(kicked, v.name)
              wait(3)
            end
        end)
    end
end)()

for _, v in next, players:GetPlayers() do
  if v ~= lp and not table.find(whitelist, v.name) then
    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/"..v.UserId.."/items/GamePass/".. 66254), 66254) then
          game.Players:ReportAbuse(v, "Cheating/Exploiting", "They keep spamming the chat using exploits. " .. math.random(1, 3e7))
          print("Kick request sent to " .. v.Name)
          table.insert(kicked, v.name)
          wait(3)
      end
   end
end

pcall(function()
    appendfile("plog.txt", "\n Perm users reported: "..table.concat(kicked, ", ").."\n Total: "..#kicked.."\n JobId: " ..game.JobId)
    print("Info saved to plog.txt")
end)

-- // https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source
while true do
    print("Joining new server.")
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)})
        local body = HttpService:JSONDecode(req.Body)
        if body and body.data then
            for _, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, 1, v.id)
                end 
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], lp)
        else
            print("Couldn't find server {Retrying}")
        end
    end
    wait(4)
end

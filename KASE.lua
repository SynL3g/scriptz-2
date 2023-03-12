local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local StarterGui = game:FindService("StarterGui")
local HttpService = game:FindService("HttpService")
local TeleportService = game:FindService("TeleportService")
local httprequest = (syn or http).request or http_request or (fluxus and fluxus.request) or request

local function cmd(cmd)
    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminClient"):WaitForChild("Signals"):WaitForChild("RequestCommand"):InvokeServer(cmd)
end

cmd("?respawn");
repeat task.wait() until lp.character;
cmd("?ff");
repeat cmd("?gear me 0000000000000000000000000000094794847") until #lp.Backpack:GetChildren() >= 6;

for _, v in next, lp.Backpack:GetChildren() do
    if v:IsA("Tool") then
         v.Parent = lp.Character
    end
end

lp.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()

courintine.wrap(function()
 wait(5)
while true do
    courintine.wrap(function()
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
            end)()
    wait(4)
end
        end)()

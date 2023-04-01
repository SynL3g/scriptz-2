local players = game:FindService("Players")
local Perm_NBC = string.match(game:HttpGet("https://inventory.roblox.com/v1/users/"..v.UserId.."/items/GamePass/".. 66254), 66254)
local Perm_BC = string.match(game:HttpGet("https://inventory.roblox.com/v1/users/"..v.UserId.."/items/GamePass/".. 64354), 64354)

players.PlayerAdded:Connect(function(v)
    if Perm_NBC or Perm_BC then
        game.Players:Chat("kick "..v.name)
    end 
end)

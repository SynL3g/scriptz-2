local players = game:FindService("Players")

players.PlayerAdded:Connect(function(v)
    if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/"..v.UserId.."/items/GamePass/".. 66254), 66254) then
        game.Players:Chat("kick "..v.name)
    end 
end)

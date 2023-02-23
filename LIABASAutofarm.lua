-- Live in a back alley simulator script [old and laggy]
-- looks like shit btw

local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local lp = Players.LocalPlayer
local Torso = lp.Character.Torso
local CurrentCamera = workspace.CurrentCamera
local tog = true

local notify = function(title, time)
   game.StarterGui:SetCore("SendNotification", {
       Title = title,
       Text = "",
       Duration = time
   })
end

local trash = {}

UserInputService.InputBegan:Connect(function(input)
   if input.KeyCode == Enum.KeyCode.Z then
       if tog == true then
           tog = false
           notify("Collector turned off", 3)
       else
           tog = true
           notify("Collector turned on", 3)
       end
   end
end)

if not getgenv().gottrash then
   trash = {}
   for _, v in next, workspace:GetDescendants() do
       if (v.Name == "hitbox" or v.Name == "2") and v:IsA("BasePart") then
           table.insert(trash, v)
       end
   end
end

getgenv().gottrash = true

while task.wait() do
   if lp.Character:FindFirstChildOfClass("Tool") and tog == true then
       for _, v in next, trash do
           if tog == true then
               v.CFrame = Torso.CFrame
               VirtualUser:Button1Down(Vector2.new(999, 0), CurrentCamera.CFrame)
               VirtualUser:Button1Up(Vector2.new(999, 0), CurrentCamera.CFrame)
           end
       end
   end
end

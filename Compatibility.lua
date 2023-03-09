-- Slightly edited version of another scropt inside of an admin script
-- (my pc is trash)
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Lighting = game:GetService("Lighting")

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9

settings().Rendering.QualityLevel = 1

for _, v in next, game:GetDescendants() do
	coroutine.wrap(function()
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v:Destroy()
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v:Destroy()
		elseif v:IsA("Explosion") then
			v:Destroy()
		end
	end)
end

for i,v in next, Lighting:GetDescendants() do
	coroutine.wrap(function()
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v:Destroy()
		end
	end)()
end

workspace.DescendantAdded:Connect(function(v)
	coroutine.wrap(function()
		if v:IsA('ForceField') then
			v:Destroy()
		elseif v:IsA('Sparkles') then
			v:Destroy()
		elseif v:IsA('Smoke') or v:IsA('Fire') then
			v:Destroy()
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v:Destroy()
		elseif v:IsA("Explosion") then
			v:Destroy()
		elseif v:IsA("Beam") then
			v:Destroy()
		end
		task.wait()
	end)
end)

setfpscap(1e6)

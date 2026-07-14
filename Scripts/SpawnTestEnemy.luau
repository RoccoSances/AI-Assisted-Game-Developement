local ServerStorage = game:GetService("ServerStorage")
local Debris = game:GetService("Debris")

local enemyTemplate = ServerStorage:WaitForChild("TestEnemy")
local enemiesFolder = workspace:WaitForChild("Enemies")

local arena = workspace:WaitForChild("Arena")
local enemySpawnsFolder = arena:WaitForChild("EnemySpawns")

local randomGenerator = Random.new()

-- Collect every valid spawn marker in EnemySpawns
local spawnPoints = {}

for _, object in enemySpawnsFolder:GetChildren() do
	if object:IsA("BasePart") then
		table.insert(spawnPoints, object)
	end
end

if #spawnPoints == 0 then
	warn("No enemy spawn points were found.")
	return
end

-- Select one spawn marker randomly
local randomIndex = randomGenerator:NextInteger(1, #spawnPoints)
local selectedSpawn = spawnPoints[randomIndex]

-- Clone the stored enemy template
local newEnemy = enemyTemplate:Clone()
newEnemy.Name = "TestEnemy"
newEnemy.Parent = enemiesFolder

-- Place the enemy at the randomly selected marker
newEnemy:PivotTo(selectedSpawn.CFrame * CFrame.new(0, 3, 0))

-- Start the enemy at full health
local humanoid = newEnemy:WaitForChild("Humanoid")
humanoid.Health = humanoid.MaxHealth

-- Remove the enemy one second after it dies
humanoid.Died:Connect(function()
	Debris:AddItem(newEnemy, 1)
end)

print("TestEnemy spawned at:", selectedSpawn.Name)
local hero = workspace.Heroes:WaitForChild("TestHero")
local enemy = workspace.Enemies:WaitForChild("TestEnemy")

local heroHumanoid = hero:WaitForChild("Humanoid")
local heroRoot = hero:WaitForChild("HumanoidRootPart")

local enemyHumanoid = enemy:WaitForChild("Humanoid")
local enemyRoot = enemy:WaitForChild("HumanoidRootPart")

local ATTACK_RANGE = 15
local DAMAGE = 25
local ATTACK_COOLDOWN = 1
local IMPACT_TIME = 0.33

-- Find or create the hero's Animator
local animator = heroHumanoid:FindFirstChildOfClass("Animator")

if not animator then
	animator = Instance.new("Animator")
	animator.Parent = heroHumanoid
end

-- Load the hero attack animation
local attackAnimation = Instance.new("Animation")
attackAnimation.AnimationId = "rbxassetid://79965604537370"

local attackTrack = animator:LoadAnimation(attackAnimation)
attackTrack.Looped = false
attackTrack.Priority = Enum.AnimationPriority.Action

-- Rotate the hero toward the enemy without moving the hero
local function faceEnemy()
	local heroPosition = hero:GetPivot().Position

	-- Keep the target at the hero's height to prevent tilting
	local targetPosition = Vector3.new(
		enemyRoot.Position.X,
		heroPosition.Y,
		enemyRoot.Position.Z
	)

	if (targetPosition - heroPosition).Magnitude > 0.01 then
		hero:PivotTo(CFrame.lookAt(heroPosition, targetPosition))
	end
end

while heroHumanoid.Health > 0 and enemyHumanoid.Health > 0 do
	local offset = enemyRoot.Position - heroRoot.Position
	local flatOffset = Vector3.new(offset.X, 0, offset.Z)
	local distance = flatOffset.Magnitude

	if distance <= ATTACK_RANGE then
		-- Only turn after the enemy enters attack range
		faceEnemy()

		attackTrack:Play()

		-- Wait for the punch impact
		task.wait(IMPACT_TIME)

		-- Check the enemy's distance again
		offset = enemyRoot.Position - heroRoot.Position
		flatOffset = Vector3.new(offset.X, 0, offset.Z)
		distance = flatOffset.Magnitude

		if enemyHumanoid.Health > 0 and distance <= ATTACK_RANGE then
			enemyHumanoid:TakeDamage(DAMAGE)

			print(
				"Hero attacked enemy. Enemy health:",
				enemyHumanoid.Health
			)
		end

		task.wait(math.max(
			ATTACK_COOLDOWN - IMPACT_TIME,
			0
			))
	else
		-- Enemy is outside the hero's range
		task.wait(0.1)
	end
end

if attackTrack.IsPlaying then
	attackTrack:Stop()
end

if enemyHumanoid.Health <= 0 then
	print("TestEnemy defeated")
end
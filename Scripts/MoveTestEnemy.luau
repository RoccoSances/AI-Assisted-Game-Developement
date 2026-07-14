local enemy = workspace.Enemies:WaitForChild("TestEnemy")
local hero = workspace.Heroes:WaitForChild("TestHero")

local enemyHumanoid = enemy:WaitForChild("Humanoid")
local enemyRoot = enemy:WaitForChild("HumanoidRootPart")

local heroHumanoid = hero:WaitForChild("Humanoid")
local heroRoot = hero:WaitForChild("HumanoidRootPart")

local MOVE_DISTANCE = 3.5
local ATTACK_RANGE = 5.5
local DAMAGE = 10
local ATTACK_COOLDOWN = 1.5
local IMPACT_TIME = 0.33

-- Find or create the enemy's Animator
local animator = enemyHumanoid:FindFirstChildOfClass("Animator")

if not animator then
	animator = Instance.new("Animator")
	animator.Parent = enemyHumanoid
end

-- Load the walking animation
local walkAnimation = Instance.new("Animation")
walkAnimation.AnimationId = "rbxassetid://507777826"

local walkTrack = animator:LoadAnimation(walkAnimation)
walkTrack.Looped = true
walkTrack.Priority = Enum.AnimationPriority.Movement

-- Load the enemy attack animation
local attackAnimation = Instance.new("Animation")
attackAnimation.AnimationId = "rbxassetid://111006026181115"

local attackTrack = animator:LoadAnimation(attackAnimation)
attackTrack.Looped = false
attackTrack.Priority = Enum.AnimationPriority.Action

while enemyHumanoid.Health > 0 and heroHumanoid.Health > 0 do
	local offset = heroRoot.Position - enemyRoot.Position
	local flatOffset = Vector3.new(offset.X, 0, offset.Z)
	local distance = flatOffset.Magnitude

	if distance > ATTACK_RANGE then
		-- Walk toward the hero
		if not walkTrack.IsPlaying then
			walkTrack:Play()
		end

		local targetPosition =
			heroRoot.Position - flatOffset.Unit * MOVE_DISTANCE

		enemyHumanoid:MoveTo(Vector3.new(
			targetPosition.X,
			enemyRoot.Position.Y,
			targetPosition.Z
			))

		task.wait(0.1)
	else
		-- Stop walking before attacking
		enemyHumanoid:MoveTo(enemyRoot.Position)

		if walkTrack.IsPlaying then
			walkTrack:Stop()
		end

		-- Play the swipe animation
		attackTrack:Play()

		-- Wait until the swipe reaches its impact pose
		task.wait(IMPACT_TIME)

		-- Check the range again before applying damage
		offset = heroRoot.Position - enemyRoot.Position
		flatOffset = Vector3.new(offset.X, 0, offset.Z)
		distance = flatOffset.Magnitude

		if heroHumanoid.Health > 0
			and enemyHumanoid.Health > 0
			and distance <= ATTACK_RANGE then

			heroHumanoid:TakeDamage(DAMAGE)

			print(
				"Enemy attacked hero. Hero health:",
				heroHumanoid.Health
			)
		end

		-- Wait for the rest of the attack cooldown
		task.wait(math.max(
			ATTACK_COOLDOWN - IMPACT_TIME,
			0
			))
	end
end

if walkTrack.IsPlaying then
	walkTrack:Stop()
end

if attackTrack.IsPlaying then
	attackTrack:Stop()
end

if heroHumanoid.Health <= 0 then
	print("TestHero was defeated")
elseif enemyHumanoid.Health <= 0 then
	print("TestEnemy was defeated")
end
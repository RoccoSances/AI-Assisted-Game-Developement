# AI-Assisted Game Development

An in-development squad-defense game prototype built in Roblox Studio with Luau, using AI assistance for scripting, debugging, system planning, documentation, and learning.

## Current Development Stage

The project is currently an early playable combat prototype. Temporary test characters and visuals are being used while the core gameplay systems are developed.

## Current Prototype Features

- Organized Roblox Studio project structure
- Fixed-position hero combat
- Eight enemy spawn locations around the arena
- Randomized enemy spawning
- Automatic enemy movement toward the hero
- Range-based targeting and hero rotation
- Hero and enemy health and damage systems
- Custom hero and enemy attack animations
- Damage synchronized with animation impact timing
- Automatic removal of defeated enemies

## Arena Setup

The test arena contains a fixed hero position and eight enemy spawn markers located around the outer edges. This allows enemies to approach the hero from different directions.

### Arena Overview

![Arena overview](Arena/Arena%20Overview.png)

### Roblox Studio Organization

The arena is organized into separate components for the floor, borders, hero spawn, arena spawn, and enemy spawn markers.

![Organized arena workspace](Arena/Organized%20Arena%20Workspace.png)

## Gameplay Scripts

The current prototype uses three main Luau scripts:

- [`SpawnTestEnemy.luau`](Scripts/SpawnTestEnemy.luau) — clones the test enemy and selects a randomized arena spawn location.
- [`MoveTestEnemy.luau`](Scripts/MoveTestEnemy.luau) — controls enemy movement and targeting toward the fixed hero.
- [`TestHeroAttack.luau`](Scripts/TestHeroAttack.luau) — controls hero targeting, rotation, attack animations, cooldowns, and damage.

## Animation Development

Custom test animations were created for both the hero and enemy using the Roblox Animation Editor. Each attack is divided into wind-up, impact, and recovery stages.

The combat scripts apply damage at the intended impact point so the visual attack and damage timing remain synchronized.

### Test Hero Attack Animation

#### Wind-Up

![Test hero wind-up](TestHero%20Animation/TestHero%20Wind%20up.png)

#### Impact

![Test hero impact](TestHero%20Animation/TestHero%20Impact.png)

#### Recovery

![Test hero recovery](TestHero%20Animation/TestHero%20Recovery.png)

### Test Enemy Attack Animation

#### Wind-Up

![Test enemy wind-up](TestEnemy%20Animation/TestEnemy%20Wind%20up.png)

#### Impact

![Test enemy impact](TestEnemy%20Animation/TestEnemy%20Impact.png)

#### Recovery

![Test enemy recovery](TestEnemy%20Animation/TestEnemy%20Recovery.png)

## AI-Assisted Development

AI is being used as a learning and development assistant throughout the project. It has helped with:

- Prototyping Luau scripts
- Troubleshooting and explaining code
- Planning gameplay systems
- Creating development guidelines
- Organizing project milestones
- Learning Roblox Studio tools and workflows

Each feature is tested and adjusted in Roblox Studio before being considered complete.

## Next Development Goals

- Support multiple enemies at the same time
- Create a basic wave-spawning system
- Scale enemy health and damage by wave
- Improve targeting for multiple enemies
- Add additional hero and enemy types
- Add user-interface elements and combat feedback

# Quests (Lite)

**FREE.** COLLECT + KILL quests for Godot 4.5+, set up in the editor with no code. Pure GDScript. MIT.

The working core of the [selodev Quests addon](docs/upgrade.md). Give the player a quest, count pickups and defeated enemies toward it, and show the progress on screen. A quest completes when every objective is met.

## 5-minute install

1. Copy `addons/quests_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Quests (Lite)**. This registers the `QuestsLite` autoload and adds two docks: **Quests · Setup** and **Quests (Lite)**.
3. In **Quests · Setup**, press **New starter quest…**. It makes `res://quests/starter_quest.tres`: collect 3 herbs and defeat 2 slimes.
4. Select your NPC, click **Give this quest when the player touches this**, then **Apply**.
5. Select a pickup, click **This counts toward a quest**, pick "Collect herb x3" under **Counts toward**, then **Apply**. Do the same on an enemy with "Defeat slime x2".
6. Select your player and press **Make the selected node the player**. Press Play.

See [docs/quick-start.md](docs/quick-start.md) for the details.

## What the Setup tab adds

| Outcome | What lands in your scene |
|---|---|
| Give this quest when the scene starts | a `QuestBoard` (`QuestBoardLite`) that starts the quest as the scene loads |
| Give this quest when the player touches this | a `QuestBoard`, plus a `QuestArea` to walk into if the node isn't an Area2D or Area3D already |
| This counts toward a quest | a `QuestTarget` (`QuestTargetLite`). Collect: the player touches it, it counts and disappears (a `PickupArea` is added if needed). Defeat: it counts when the enemy's Health sends `died` |

Every outcome also adds a `QuestTracker` at the top right, once per scene (untick **Show the quest tracker (J)** to leave it out). It lists the active quests with each objective's progress, and **J** hides and shows it. Short messages show at the top of the screen: "Quest started: …", "+1 herb", "Quest complete: …".

Apply again to change a node: it updates the same nodes and never adds a second set. Everything it adds is a plain node you can tweak in the Inspector.

## From code (optional)

The nodes above call the `QuestsLite` autoload for you. You can call it yourself too:

```gdscript
var obj := QuestObjectiveLite.new()
obj.id = "kill_wolves"
obj.type = QuestObjectiveLite.Type.KILL
obj.target_id = "wolf"
obj.required = 3

var quest := QuestLite.new()
quest.id = "wolves"
quest.title = "Wolf Trouble"
quest.objectives = [obj]

QuestsLite.register(quest)
QuestsLite.start_quest("wolves")
QuestsLite.report_kill("wolf", 1)   # progress: 1/3
QuestsLite.report_kill("wolf", 2)   # progress: 3/3 → quest_completed fires
```

## What's missing (and why)

| Feature | Tier |
|---|---|
| Objective types: USE, CURRENCY, TALK, REACH, FLAG, CUSTOM | Pro |
| Quest chains (`prerequisite_quests`) | Pro |
| Condition prerequisites (flags, level, biome) | Pro |
| Optional + hidden objectives | Pro |
| Rewards (ITEM, CURRENCY, FLAG, CUSTOM) | Pro |
| Time limits + repeatable | Pro |
| `QuestGiver` Node (talk to take and hand in quests) + `QuestLogUI` Control with tabs | Pro |
| Objectives and rewards authored in the dock (Lite edits objectives in the Inspector) | Pro |
| Save-contract auto-join + shared `Events` bus | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


## Part of a family

This is one free tier from the selodev catalog of no-code Godot 4 systems. They share an item contract and a save contract, so they plug into each other, and each one also works fully on its own.

Free systems:

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite)
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite)
- [Loot Lite](https://github.com/seloc0des/godot-loot-lite)
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite)
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite)
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite)
- [Stats / Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite)
- [Save / Load Lite](https://github.com/seloc0des/godot-save-load-lite)
- [Dialogue Lite](https://github.com/seloc0des/godot-dialogue-lite)
- [Combat Lite](https://github.com/seloc0des/godot-combat-lite)
- [Controller Lite](https://github.com/seloc0des/godot-controller-lite)
- [Enemy AI Lite](https://github.com/seloc0des/godot-enemy-ai-lite)
- [Scene Flow Lite](https://github.com/seloc0des/godot-scene-flow-lite)
- [Audio Lite](https://github.com/seloc0des/godot-audio-lite)
- [Level Builder Lite](https://github.com/seloc0des/godot-level-builder-lite)
- [Weather System Lite](https://github.com/seloc0des/godot-weather-lite)
- [Settings + Menus](https://github.com/seloc0des/godot-settings-menus) (complete and free, no paid tier)

Free VFX: [Magic Cast](https://github.com/seloc0des/godot-magic-cast-vfx-lite), [Elemental Impact](https://github.com/seloc0des/godot-elemental-impact-vfx-lite), [Explosion](https://github.com/seloc0des/godot-explosion-vfx-lite), [Pickup, Buff & Heal](https://github.com/seloc0des/godot-pickup-buff-vfx-lite).

Free starter projects: [Free Starter](https://github.com/seloc0des/free-starter-godot), [Dungeon](https://github.com/seloc0des/godot-dungeon-starter), [Survival](https://github.com/seloc0des/godot-survival-starter), [RPG](https://github.com/seloc0des/godot-rpg-starter).

The full versions add drop-in UI, editor docks and the cross-system wiring. They're on itch.io: **https://selodev.itch.io**

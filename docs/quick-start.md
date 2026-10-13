# Quick Start

Goal: an NPC that gives a quest, pickups and an enemy that count toward it, and a tracker that shows the progress, with no code.

## 1. Install

- Copy `addons/quests_lite/` into your project's `addons/` folder.
- Enable **Quests (Lite)** in Project → Project Settings → Plugins. That adds the `QuestsLite` autoload and two docks: **Quests · Setup** (puts quests into your scene) and **Quests (Lite)** (writes the quests).

## 2. Make a quest

In **Quests · Setup**, press **New starter quest…**. It makes `res://quests/starter_quest.tres` with two objectives, collect 3 herbs and defeat 2 slimes, and picks it in the quest list.

To write your own: in the **Quests (Lite)** tab press **New**. It makes `res://quests/new_quest.tres` (then `new_quest_2.tres`, and so on) with the id `new_quest` and the title "New Quest", and opens it in the Inspector. Change the title in the tab or the Inspector, and **Save**. Objectives are edited in the Inspector: for an older quest, pick it in **Quests · Setup** and press **Edit this quest…**. Under **Objectives** add an element, choose **New QuestObjectiveLite**, and set its **Type** (Collect or Kill), **Target Id** (for example `herb`) and **Required** (how many). Press **Refresh** in **Quests · Setup** to see it.

## 3. Give the quest to the player

1. Open your level and select the NPC in the Scene tree.
2. In **Quests · Setup**, click **Give this quest when the player touches this**.
3. Pick the quest and click **Apply**.

Apply adds a `QuestBoard` under the NPC and a `QuestArea` (an Area2D or Area3D with a round shape) for the player to walk into. An NPC that already is an Area2D or Area3D is used as it is, and gets a shape if it has none.

**Give this quest when the scene starts** starts the quest as soon as the scene loads. With nothing selected, its `QuestBoard` goes on the scene root.

## 4. Count pickups and enemies

1. Select a pickup (a herb sprite, a chest).
2. Click **This counts toward a quest**, pick the quest, and under **Counts toward** pick the objective, for example "Collect herb x3".
3. Click **Apply**.

Apply adds a `QuestTarget` under the pickup, and a `PickupArea` if it isn't an Area2D or Area3D. When the player touches it, it counts and the pickup disappears. A pickup stays where it is until a quest that needs it is active, so the player can't use it up early. To place more herbs, duplicate the pickup (Ctrl+D): its `QuestTarget` comes with it.

For a Kill objective, select the enemy and pick "Defeat slime x2". It counts when the enemy's Health sends its `died` signal, so the enemy needs a Health node (the Combat pack's Health works). If it has none, the status line says so.

## 5. The player

Touch only counts for the node in the `player` group. If nothing in the scene is in it yet, the status line says so: select your player and click **Make the selected node the player**. Your player also needs its own collision shape to touch anything.

## 6. The tracker and messages

Every outcome also adds a `QuestTracker` at the top right of the screen, once per scene, and puts the `quest_log` action on **J** in the Input Map. It lists each active quest with its objectives ("Collect herb 1/3"), marks finished ones, and a quest completed while it's up stays on it marked complete. **J** hides and shows it. Untick **Show the quest tracker (J)** before Apply to leave it out.

Short messages show at the top of the screen: "Quest started: …" from the board, "+1 herb" from a pickup, and "Collect herb 3/3 done" and "Quest complete: …" from the tracker. Each node has a **Show Messages** checkbox in the Inspector to turn its messages off.

Re-pick and Apply to change a node: it updates the same `QuestBoard` or `QuestTarget`, never a second one. All of them are plain nodes, so you can also change their fields in the Inspector or drag another quest onto a board's **Quest** field.

## 7. Scenes made with 1.2

Older versions added a `QuestBoard` that did nothing on its own. Those scenes still load and behave as before. Select the node it sits on, pick an outcome and press **Apply**: the old board turns into a working `QuestBoard` and keeps its quest.

## From code (optional)

The nodes above call the `QuestsLite` autoload for you. Everything below is for your own scripts.

### Author quests

```gdscript
const QuestObjectiveLite := preload("res://addons/quests_lite/quest_objective_lite.gd")
const QuestLite := preload("res://addons/quests_lite/quest_lite.gd")

var obj := QuestObjectiveLite.new()
obj.id = "collect_herbs"
obj.type = QuestObjectiveLite.Type.COLLECT
obj.target_id = "herb"
obj.required = 5

var quest := QuestLite.new()
quest.id = "herbs_for_alchemist"
quest.title = "Herbs for the Alchemist"
quest.objectives = [obj]
```

### Register and start

```gdscript
QuestsLite.register(quest)
# or in bulk:
QuestsLite.register_many([quest1, quest2, quest3])

QuestsLite.start_quest("herbs_for_alchemist")
```

### Report progress

```gdscript
# When the player picks up an item:
QuestsLite.report_collect("herb", 1)

# When an enemy dies:
QuestsLite.report_kill("wolf", 1)
```

Only **active** quests with matching `type` + `target_id` advance. Unmatched reports are ignored.

### Listen

```gdscript
QuestsLite.objective_progressed.connect(func(qid, oid, current, required):
    print("%s: %s → %d/%d" % [qid, oid, current, required]))

QuestsLite.quest_completed.connect(func(qid):
    grant_reward_via_my_own_code(qid))
```

### Inspect

```gdscript
QuestsLite.get_state("herbs_for_alchemist")   # 0=AVAILABLE, 1=ACTIVE, 2=COMPLETE
QuestsLite.get_progress("herbs_for_alchemist", "collect_herbs")  # int
QuestsLite.is_complete("herbs_for_alchemist")
QuestsLite.list_quests()                     # all registered
```

### Hooking to your own inventory or combat

A `QuestTarget` covers touching a pickup and an enemy's `died` signal. If your game gives items or counts kills some other way, report them yourself:

```gdscript
# In your loot pickup:
inventory.add_item(item, n)
QuestsLite.report_collect(String(item.id), n)

# In your enemy death:
QuestsLite.report_kill(enemy_id, 1)
```

The **Pro tier** hears the Inventory and Combat packs on its own through the shared `Events` autoload.

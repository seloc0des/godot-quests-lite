# Quick Start

## Author quests

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

## Register and start

```gdscript
QuestsLite.register(quest)
# or in bulk:
QuestsLite.register_many([quest1, quest2, quest3])

QuestsLite.start_quest("herbs_for_alchemist")
```

## Report progress

```gdscript
# When the player picks up an item:
QuestsLite.report_collect("herb", 1)

# When an enemy dies:
QuestsLite.report_kill("wolf", 1)
```

Only **active** quests with matching `type` + `target_id` advance. Unmatched reports are ignored.

## Listen

```gdscript
QuestsLite.objective_progressed.connect(func(qid, oid, current, required):
    print("%s: %s → %d/%d" % [qid, oid, current, required]))

QuestsLite.quest_completed.connect(func(qid):
    grant_reward_via_my_own_code(qid))
```

## Inspect

```gdscript
QuestsLite.get_state("herbs_for_alchemist")   # 0=AVAILABLE, 1=ACTIVE, 2=COMPLETE
QuestsLite.get_progress("herbs_for_alchemist", "collect_herbs")  # int
QuestsLite.is_complete("herbs_for_alchemist")
QuestsLite.list_quests()                     # all registered
```

## Hooking to inventory / combat

The Lite tier doesn't auto-listen to bus events. Call `report_collect` / `report_kill` from your own pickup / combat code:

```gdscript
# In your loot pickup:
inventory.add_item(item, n)
QuestsLite.report_collect(String(item.id), n)

# In your enemy death:
emit_signal("died")
QuestsLite.report_kill(enemy_id, 1)
```

The **Pro tier** wires this automatically via the shared `Events` autoload.

# Quests — Lite

**FREE.** COLLECT + KILL quest tracking for Godot 4.3+. Pure GDScript. MIT.

The working core of the [CindieForge Quests addon](docs/upgrade.md). Register quests, start them, report progress, auto-completes when every objective is met.

## 5-minute install

1. Copy `addons/quests_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Quests — Lite**.
3. The plugin registers the `QuestsLite` autoload.
4. Build `QuestLite` Resources with `QuestObjectiveLite`s (COLLECT or KILL).
5. `QuestsLite.register(quest)`, `QuestsLite.start_quest(id)`.
6. Report progress: `QuestsLite.report_collect("herb", 1)`, `QuestsLite.report_kill("wolf", 1)`.

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
| `QuestGiver` Node + `QuestLogUI` Control | Pro |
| Save-contract auto-join + shared `Events` bus | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


---

## Part of a family

The free Lite tier of one system in a set of Godot 4 RPG systems built to
interoperate (shared item + save contracts) — each also works fully standalone.

**Free tiers — try before you buy:**

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite) — item slots, stack merging, capacity
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite) — 4-slot gear manager
- [Save/Load Lite](https://github.com/seloc0des/godot-save-load-lite) — single-slot JSON persistence
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite) — shapeless instant recipes
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite) — COLLECT + KILL quests
- [Stats/Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite) — stat aggregator
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite) — single fixed-currency shop
- [Settings + Menu System](https://github.com/seloc0des/godot-settings-menus) — complete, free, no paid tier

**Full versions** — drop-in UI, weight/categories, timed crafting, restock & currencies,
save-aware cross-system integration, and more — are on itch.io:
**https://selodev.itch.io**

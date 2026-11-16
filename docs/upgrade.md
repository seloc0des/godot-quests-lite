# Upgrade to Quests (Pro)

## What Pro adds

- **Six more objective types.** USE (consume N), CURRENCY (earn N), TALK (NPC dialogue), REACH (region), FLAG (story beat), CUSTOM (anything). 8 total vs. 2.
- **Quest chains.** `prerequisite_quests = ["chapter_1"]` gates Chapter 2 until Chapter 1 completes.
- **Condition prerequisites.** `min_level`, flag list, biome list, item ownership.
- **Optional + hidden objectives.** Bonus objectives that don't gate completion. Hidden objectives that surface mid-quest.
- **Rewards.** ITEM, CURRENCY, FLAG, CUSTOM. Auto-grant on completion or claim-on-pickup.
- **Time limits.** Fail timer per quest. Repeatable quests for dailies / championships.
- **`QuestGiver` Node.** Per-NPC quest list, `talk()` fires TALK events, optional auto-turn-in.
- **`QuestLogUI` Control.** Available / Active / Complete tabs, detail pane, action buttons.
- **Save-contract auto-join.** Quest state, progress per objective, flags, context, currency baselines all persist.
- **Shared `Events` autoload.** Auto-listens for `item_acquired` / `enemy_killed` / `region_reached` from the rest of the RPG Toolkit — no glue code.

## Moving from Lite

The full version installs next to the Lite, in its own folder, and both run in the same project, so you can move over one piece at a time. It isn't a drop-in replacement: the class names differ, and so do some method names.

`QuestLite` becomes `Quest`, and the `QuestsLite` autoload becomes `QuestManager`. `register`, `start_quest`, `is_active` and `is_complete` keep their names. `report_collect(item, n)` and `report_kill(enemy, n)` become `report(event_type, key, amount)`. Your `QuestLite.tres` files stay Lite resources, so re-create them as full quests. The fields have the same names, but objective types are numbered differently (`KILL` is 1 in the Lite and 3 in the full version), so pick each objective's type again rather than copying the number.

## Where to buy

The full version is on itch.io: **https://selodev.itch.io**.

## License

MIT.

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

## Migration from Lite

`QuestLite.objectives` use a subset of the same shape Pro `Quest.objectives` use. Drop your `.tres` files into the Pro project; they read as quests with only COLLECT / KILL objectives. Add prerequisites / rewards / extra objective types in the Pro Inspector.

## Where to buy

The full version is on itch.io — **https://selodev.itch.io**. Both tiers share the
same field names and method signatures, so upgrading is a class-name swap.

## License

MIT.

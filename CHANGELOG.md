# Changelog

## 1.3.0 (2026-08-22)

- Engine floor moves to Godot 4.5. The project and the plugin description both
  said 4.3 before, which no longer matched the code.
- The addon and its docs now say selodev throughout. The old CindieForge name
  was still in the README and the upgrade notes after the rebrand.

## 1.2.0 — 2026-07-24

One-click no-code setup.

- New **Quests · Setup** panel (the first dock tab): pick the outcome you want → **Apply** → the Lite component is added to your scene, baked in and re-editable.
- Pro unlocks the full no-code wiring — gameplay triggers, bound UI, and cross-system hooks.

## 1.1.0 — 2026-07-24

No-code authoring dock.

- New editor dock: author `QuestLite` quests through a UI panel — create, edit, duplicate, delete, no `.tres` hand-editing. (The Pro tier adds every field, one-click scene wiring, and the `EventTrigger` node.)

## 1.0.0 — 2026-06-01

Initial release.

- `QuestLite` Resource — id, title, description, objectives.
- `QuestObjectiveLite` Resource — id, type (COLLECT / KILL), target_id, required.
- `QuestsLite` autoload — register / start / report / inspect, auto-completes.
- States: AVAILABLE, ACTIVE, COMPLETE.
- Signals: `quest_registered`, `quest_started`, `quest_completed`, `objective_progressed`, `objective_completed`.
- Demo: 2 quests (collect 5 herbs, kill 3 wolves) with action buttons + live progress panel.

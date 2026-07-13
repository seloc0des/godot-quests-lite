# Changelog

## 1.0.0 — 2026-06-01

Initial release.

- `QuestLite` Resource — id, title, description, objectives.
- `QuestObjectiveLite` Resource — id, type (COLLECT / KILL), target_id, required.
- `QuestsLite` autoload — register / start / report / inspect, auto-completes.
- States: AVAILABLE, ACTIVE, COMPLETE.
- Signals: `quest_registered`, `quest_started`, `quest_completed`, `objective_progressed`, `objective_completed`.
- Demo: 2 quests (collect 5 herbs, kill 3 wolves) with action buttons + live progress panel.

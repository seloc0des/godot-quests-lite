# Changelog

## 1.4.4 (2026-10-12)

The tabs show their names on Godot 4.5.

- **The Quests · Setup and Quests (Lite) tabs were blank on Godot 4.5.** Their tabs beside the
  Inspector had no title, so "open the Quests · Setup tab" pointed at nothing. They are named when
  the pack switches on now. Godot 4.7 was not affected.

## 1.4.3 (2026-09-28)

- **The Quests (Lite) list shows quest titles** instead of file names. A quest with no title still
  shows its file name, and the list catches up as soon as you press Save.

## 1.4.2 (2026-09-28)

Lists that stay readable at any editor scale.

- **The Quests (Lite) list always shows about five rows**, at any editor scale. At 125% it came out
  a few rows tall. The divider under it still drags.
- **A file the tab makes is registered with Godot as soon as it's written**, so pressing Play
  straight away can't warn "invalid UID".

## 1.4.1 (2026-09-27)

Installs without errors, each objective counts on its own, and both tabs fit a default dock.

- **No red errors when you install it.** Installing it filled the Output panel with "Failed to
  load script" errors for its demo and self-test before you'd even switched it on. They named a
  part of the pack that only exists once the pack is on.
- **Objectives with a blank Objective ID each count on their own.** Before, collecting the herbs
  alone could finish a quest that also asked you to defeat the slimes.
- **The Setup and authoring tabs fit a default dock.** A tab taller than the dock scrolls, and lists
  show what you just made the next time they open.

## 1.4.0 (2026-09-27)

Quests you can use without writing code.

- **Quests with no code.** The Setup tab gives a quest when the scene starts or when the player
  touches something, and makes pickups and enemies count toward it. You pick the objective from a
  list, nothing typed.
- **A quest tracker** at the top right shows the active quests and how far along each objective is.
  J hides and shows it.
- **Short messages on screen** when a quest starts, an objective is done and a quest is complete.
- **Enabling the plugin registers the QuestsLite autoload.** It never did, so in a project of your
  own every QuestsLite call the docs describe failed to parse.
- **Apply fills in blank or repeated quest and objective ids**, which used to stop a quest from
  registering without a word.
- A pickup only counts while an active quest still needs it, so the player can't use one up early.
- **The Quests (Lite) tab shows its fields in the editor.** It was empty there.
- **New in the tab gives the quest a title** ("New Quest", new_quest) and opens it in the Inspector,
  and edits made in the Inspector, objectives included, survive the tab's Save.
- Scenes built with the old QuestBoard are converted the next time you press Apply.
- **Pressing Play right after Apply includes what it added.** The Setup tab never marked the scene
  as changed, so Play ran the saved version without it.
- **Saving in the Quests tab keeps your scenes linked to the file** instead of leaving them an
  orphaned copy that the scene then saved inside itself.
- **Nodes the Setup tab adds get readable names.** A second one under the same parent is
  called something like `UILayer2`, instead of a generated name full of `@` signs.
- **Switching the plugin off only removes the autoload if the plugin added it**, and closing
  the editor no longer removes it at all. A project that declares it itself, like the starter
  kits, keeps it.
- **Long status messages in the authoring tab wrap** instead of running off the edge of the dock.

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

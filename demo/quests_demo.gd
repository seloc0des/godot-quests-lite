extends Node

const QuestLiteScript := preload("res://addons/quests_lite/quest_lite.gd")
const QuestObjectiveLiteScript := preload("res://addons/quests_lite/quest_objective_lite.gd")

var _quest_panel: VBoxContainer
var _quest_a: QuestLite
var _quest_b: QuestLite


func _ready() -> void:
	var bg := ColorRect.new()
	bg.color = Color(0.10, 0.12, 0.16)
	bg.anchor_right = 1; bg.anchor_bottom = 1
	add_child(bg)

	# Quest A: collect 5 herbs.
	_quest_a = _build_quest("herbs", "Herbs for the Alchemist",
		"Pick five wild herbs.",
		[_obj("collect_herbs", QuestObjectiveLite.Type.COLLECT, "herb", 5)])

	# Quest B: kill 3 wolves.
	_quest_b = _build_quest("wolves", "Wolf Trouble",
		"Slay three wolves.",
		[_obj("kill_wolves", QuestObjectiveLite.Type.KILL, "wolf", 3)])

	QuestsLite.register(_quest_a)
	QuestsLite.register(_quest_b)

	QuestsLite.objective_progressed.connect(_refresh.unbind(4))
	QuestsLite.quest_started.connect(_refresh.unbind(1))
	QuestsLite.quest_completed.connect(_refresh.unbind(1))

	_build_ui()
	_refresh()


func _obj(id_: String, type: int, target: String, n: int) -> QuestObjectiveLite:
	var o := QuestObjectiveLiteScript.new()
	o.id = id_; o.type = type; o.target_id = target; o.required = n
	return o


func _build_quest(id_: String, title: String, desc: String, objectives: Array) -> QuestLite:
	var q := QuestLiteScript.new()
	q.id = id_; q.title = title; q.description = desc
	# QuestLite.objectives is typed Array[QuestObjectiveLite] — pack into the
	# typed array so Godot 4.5 doesn't reject the assignment.
	var typed: Array[QuestObjectiveLite] = []
	for o in objectives:
		if o is QuestObjectiveLite:
			typed.append(o)
	q.objectives = typed
	return q


func _build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var title := Label.new()
	title.text = "Quests — Lite — Demo"
	title.position = Vector2(16, 12)
	title.add_theme_font_size_override("font_size", 16)
	layer.add_child(title)

	# Action buttons (left).
	var btns := VBoxContainer.new()
	btns.position = Vector2(16, 48)
	btns.add_theme_constant_override("separation", 4)
	layer.add_child(btns)
	_add_btn(btns, "Start Herbs quest", func(): QuestsLite.start_quest("herbs"))
	_add_btn(btns, "Start Wolves quest", func(): QuestsLite.start_quest("wolves"))
	_add_btn(btns, "+1 Herb", func(): QuestsLite.report_collect("herb", 1))
	_add_btn(btns, "+5 Herbs", func(): QuestsLite.report_collect("herb", 5))
	_add_btn(btns, "Slay a wolf", func(): QuestsLite.report_kill("wolf", 1))
	_add_btn(btns, "Slay a bear (noise)", func(): QuestsLite.report_kill("bear", 1))

	# Quest panel (right).
	var panel := PanelContainer.new()
	panel.position = Vector2(340, 48)
	panel.custom_minimum_size = Vector2(540, 440)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.04, 0.05, 0.07)
	sb.border_color = Color(0.20, 0.22, 0.28)
	sb.set_border_width_all(1); sb.set_corner_radius_all(4)
	sb.content_margin_left = 12; sb.content_margin_right = 12
	sb.content_margin_top = 12; sb.content_margin_bottom = 12
	panel.add_theme_stylebox_override("panel", sb)
	layer.add_child(panel)
	_quest_panel = VBoxContainer.new()
	_quest_panel.add_theme_constant_override("separation", 8)
	panel.add_child(_quest_panel)


func _add_btn(parent: Container, text: String, cb: Callable) -> void:
	var b := Button.new()
	b.text = text
	b.pressed.connect(cb)
	parent.add_child(b)


func _refresh() -> void:
	for c in _quest_panel.get_children():
		c.queue_free()
	var hdr := Label.new()
	hdr.text = "Quests"
	hdr.add_theme_font_size_override("font_size", 15)
	_quest_panel.add_child(hdr)
	for q in [_quest_a, _quest_b]:
		var state: int = QuestsLite.get_state(String(q.id))
		var state_str: String = ["AVAILABLE", "ACTIVE", "COMPLETE"][state]
		var title := Label.new()
		title.text = "%s — %s" % [String(q.title), state_str]
		title.add_theme_font_size_override("font_size", 13)
		title.modulate = Color(0.6, 0.9, 0.6) if state == 2 else (Color(0.9, 0.85, 0.6) if state == 1 else Color(0.7, 0.7, 0.7))
		_quest_panel.add_child(title)
		for o in q.objectives:
			var line := Label.new()
			var prog := QuestsLite.get_progress(String(q.id), String(o.id))
			line.text = "    • %s/%d %s" % [str(prog), int(o.required), String(o.target_id)]
			line.add_theme_font_size_override("font_size", 12)
			_quest_panel.add_child(line)

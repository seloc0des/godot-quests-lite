@tool
extends EditorPlugin

const Q_NAME := "QuestsLite"
const Q_PATH := "res://addons/quests_lite/quest_manager_lite.gd"


func _enter_tree() -> void:
	add_autoload_singleton(Q_NAME, Q_PATH)


func _exit_tree() -> void:
	remove_autoload_singleton(Q_NAME)

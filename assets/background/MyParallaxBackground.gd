tool
extends ParallaxBackground
class_name MyParallaxBackground

export(Vector2) var window_size = null

export(Texture) var add_layer = null setget add_layer
func add_layer(_val):
	if not _val:
		add_layer = _val
		return
	var new_layer = MyParallaxLayer.new()
	new_layer.region_enabled = true
	new_layer.region_rect.size = window_size/scale
	new_layer.name = "layer 1"
	new_layer.texture = _val
	new_layer.centered = false
	add_child(new_layer)
	new_layer.set_owner(get_tree().edited_scene_root)

func _enter_tree():
	if Engine.editor_hint and not window_size:
		window_size = Vector2()
		window_size.x = ProjectSettings.get("display/window/size/width")
		window_size.y = ProjectSettings.get("display/window/size/height")

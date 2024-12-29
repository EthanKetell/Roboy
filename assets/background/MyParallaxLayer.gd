extends Sprite
class_name MyParallaxLayer

onready var parent:ParallaxBackground = get_parent()

export var scroll_scale := Vector2.ONE
export var scroll_offset := Vector2()
export var scroll_bonus := Vector2()

var bonus_amount = Vector2()

func _process(delta):
	bonus_amount += scroll_bonus * delta
	region_rect.position = -(scroll_offset + parent.scroll_offset*scroll_scale) + bonus_amount

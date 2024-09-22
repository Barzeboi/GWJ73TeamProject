extends StaticBody2D
class_name Block

@export var type: BlockType

func _ready():
	var sprite = get_node("./Sprite")
	sprite.texture = type.texture

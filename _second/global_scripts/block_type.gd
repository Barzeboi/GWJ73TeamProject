extends Resource
class_name BlockType

static var YELLOW := load("res://_second/yellow_block_type.tres")
static var PURPLE := load("res://_second/purple_block_type.tres")
static var NEUTRAL := load("res://_second/neutral_block_type.tres")
static var ALL := [YELLOW, PURPLE]

@export var texture: Texture
# ... have attack point ? Effect ? headTexture ...

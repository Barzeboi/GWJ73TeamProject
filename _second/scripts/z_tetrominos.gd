extends Tetromino
class_name ZTetromino

func initialize():
	origin = $Markers/O
	rotation_point = $RotationPoint
	default_blocks = {
		$Markers/A: BlockType.YELLOW,
		$Markers/B: BlockType.YELLOW,
		$Markers/O: BlockType.YELLOW,
		$Markers/D: BlockType.YELLOW,
	}

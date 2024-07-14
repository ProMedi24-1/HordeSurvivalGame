extends ParallaxBackground

func _process(delta: float) -> void:
    self.scroll_base_offset.x += 1000 * delta

class_name Poller

## Execute the callback after a certain number of seconds.
static func poll_by_second(seconds: float, callback: Callable) -> void:
    pass

## Execute the callback after a certain number of frames.
static func poll_by_frame(frames: int, callback: Callable) -> void:
    pass

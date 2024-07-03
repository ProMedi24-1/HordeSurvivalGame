class_name MusicPlayer extends AudioStreamPlayer

@export var track: AudioStream
@export var loop: bool = true

func _ready() -> void:
    bus = "Music"
    self.connect("finished", loopAudio)

    if track:
        set_stream(track)
        play()

func loopAudio() -> void:
    if loop:
        play()

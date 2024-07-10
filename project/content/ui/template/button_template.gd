extends Button
## Base class for all buttons.

## Button states.
enum ButtonState {
	NORMAL,
	FOCUSED,
	PRESSED,
}

const HOVER_SCALE := 1.05
const DOWN_SCALE := 1.02

var state: ButtonState = ButtonState.NORMAL  ## The current state of the button.
var std_scale: Vector2  ## The standard scale of the button.
var press_event := Callable()  ## The event to call when the button is pressed.


func _ready() -> void:
	pressed.connect(on_pressed)
	focus_entered.connect(on_focus_begin)
	focus_exited.connect(on_focus_end)
	mouse_entered.connect(on_hover_begin)
	button_down.connect(on_down)
	button_up.connect(on_up)

	std_scale = scale

	# NOTE: does not work somehow?
	pivot_offset = Vector2(size.x / 2, size.y / 2)


## Change the state of the button.
## [new_state]: The new state of the button.
func change_state(new_state: ButtonState) -> void:
	state = new_state

	match state:
		ButtonState.NORMAL:
			create_tween().tween_property(self, "scale", std_scale, 0.03)
		ButtonState.FOCUSED:
			create_tween().tween_property(self, "scale", std_scale * HOVER_SCALE, 0.03)
		ButtonState.PRESSED:
			create_tween().tween_property(self, "scale", std_scale * DOWN_SCALE, 0.03)


## Call the press event.
func on_pressed() -> void:
	if not press_event.is_null():
		press_event.call()


## On button down. When the button is pressed.
func on_down() -> void:
	Sound.play_sfx(Sound.Fx.CLICK, 2)
	change_state(ButtonState.PRESSED)


## On button up. When the button is released.
func on_up() -> void:
	change_state(ButtonState.FOCUSED)


## On focus begin, when the mouse hovers over the button.
func on_focus_begin() -> void:
	Sound.play_sfx(Sound.Fx.HOVER, 2, 0.5)
	change_state(ButtonState.FOCUSED)


## On focus end, when the mouse leaves the button.
func on_focus_end() -> void:
	change_state(ButtonState.NORMAL)


## Grab focus when the mouse hovers over the button.
func on_hover_begin() -> void:
	self.grab_focus()

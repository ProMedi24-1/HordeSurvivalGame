class_name CircBuffer
## A circular buffer class for managing a fixed-size list of elements.

var buffer: Array  ## The array that holds the elements of the circular buffer.
var buf_size: int  ## The maximum size of the buffer.


## Constructor for the circular buffer.
## [size]: The maximum number of elements the buffer can hold.
func _init(size: int):
	self.buffer = []
	self.buf_size = size


## Adds an element to the end of the buffer. If the buffer is full, the oldest element is removed.
## [element]: The element to add to the buffer.
func push_back(element: Variant) -> void:
	self.buffer.push_back(element)
	if self.buffer.size() > self.buf_size:
		self.buffer.pop_front()


## Removes and returns the oldest element from the buffer.
## [return]: The element that was removed from the buffer.
func pop_front() -> Variant:
	return self.buffer.pop_front()


## Checks if the buffer is empty.
## [return]: True if the buffer is empty, False otherwise.
func empty() -> bool:
	return self.buffer.is_empty()

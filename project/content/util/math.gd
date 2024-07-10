class_name Math
## A Math class providing static math utility functions.


## Static method to calculate the sum of all elements in an array.
## [arr]: The array of elements to be summed.
## [return]: The sum of all elements in the array.
static func accumulate(arr: Array) -> Variant:
	var sum := 0
	for i in arr:
		sum += i
	return sum

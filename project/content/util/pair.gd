class_name Pair
## A Pair class designed to hold two related values or objects together.

var first  ## The first element of the pair.
var second  ## The second element of the pair.


## Constructor for initializing a Pair object with two elements.
## [first_type]: The first element of the pair.
## [second_type]: The second element of the pair.
func _init(first_type: Variant, second_type: Variant):
	self.first = first_type
	self.second = second_type


## Swaps the first and second elements of the pair.
func swap() -> void:
	var tmp = self.first
	self.first = self.second
	self.second = tmp

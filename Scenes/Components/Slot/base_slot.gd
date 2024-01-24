extends Node2D
class_name Slot

@export var item : String
signal current_item(item_name)

# Function that tell user that character is having weapon or not
func is_null():
	if (!item): return true
	else: return false

# Function that receive other item and switch it to current item
# There are two cases: when character are not have any weapon yet
# and they have already.
# After switch, this function have to return the item its hold before switch

func switch(new_item: String):
	# In case that item is the same, do not do anything
	if (item == new_item): return
	if (item):  emit_signal("current_item", item)
	else:  print("Got item: " + new_item)
	item = new_item


func display():
	if (item): print("Item: " + item)
	else: print("There don't have any item.")

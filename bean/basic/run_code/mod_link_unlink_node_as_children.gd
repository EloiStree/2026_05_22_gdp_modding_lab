
## Allows to link code when Mod Node is created
## Then unlink when a new one is create or the current is destroy
class_name ModLinkUnlinkNodesAsChildren
extends Node


@export var what_to_link:Array[Node]
@export var where_to_store_when_unlink:Node

func link_to_node(node:Node):
	for n in what_to_link:
		if n:
			n.reparent(node,true)

func unlink():
	for n in what_to_link:
		if n:
			n.reparent(where_to_store_when_unlink,true)
	

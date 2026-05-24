class_name ModTextureToMeshInstanceSurface	
extends Node

@export var mesh_instance: MeshInstance3D
@export var surface_index: int = 0


func load_texture_to_surface(texture: Texture2D) -> void:
	var material_surface := mesh_instance.get_surface_override_material(surface_index)
	if material_surface is StandardMaterial3D:
		material_surface.albedo_texture = texture
		
	var material := mesh_instance.get_active_material(surface_index)
	if material is StandardMaterial3D:
		material.albedo_texture = texture
		

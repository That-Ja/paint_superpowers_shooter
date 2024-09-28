extends CSGBox3D




func _on_camera_3d_extra_box_pos(extra_box_x, extra_box_y, extra_box_z):
	self.position.x = self.position.x+ extra_box_x
	self.position.y = self.position.y+ extra_box_y
	self.position.z = self.position.z+ extra_box_z

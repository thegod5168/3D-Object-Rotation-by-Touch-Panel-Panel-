3D Object Rotation by Touch Panel (หันวัตถุอย่างละเอียดตามการสัมผัสใน Panel)

การทำงาน (How it works)

ภาษาไทย
โปรเจกต์นี้ช่วยให้คุณสามารถ:

หมุนวัตถุ 3D ตามการสัมผัสบนหน้าจอผ่าน Panel

รองรับการสัมผัสหลายจุด (Multi-touch)

ปรับแต่งค่าความไวในการหมุนและแกนที่ใช้ได้อย่างยืดหยุ่น

มีโหมดเปิด/ปิดการควบคุมด้วยการสัมผัส


English
This project allows you to:

Rotate 3D objects based on touch gestures on a Panel

Support multi-touch interactions

Adjust rotation sensitivity and axes flexibly

Enable/disable touch control mode



---

ฟีเจอร์ (Features)

ภาษาไทย

1. รับการสัมผัสใน Panel และหมุนวัตถุ 3D ตามการลากนิ้ว


2. สามารถกำหนดค่าความไว (sensitivity) ของการหมุนในแกน X และ Y


3. รองรับการตั้งค่า Node 3D สำหรับแกนหมุนที่ต้องการใน Editor


4. สามารถเปิด/ปิดโหมดการควบคุมการสัมผัสได้ด้วยตัวแปร Boolean



English

1. Detect touch gestures in a Panel to rotate 3D objects based on drag movements


2. Adjustable rotation sensitivity (sensitivity) for both X and Y axes


3. Configurable 3D Nodes for rotation axes through the Editor


4. Toggle touch control mode with a Boolean variable




---

ตัวอย่างการใช้งาน (Usage Example)

สคริปต์หลัก (Main Script):

extends Panel

#float
@export var sensitivity_x: float = 0.5
@export var sensitivity_y: float = 0.5 

#Node
@export var Object_rotating_on_the_x_axis: Node3D
@export var Object_rotating_on_the_y_axis : Node3D

#bool
@export var Touch_control_mode: bool = true 

var touch_positions = {}  
var touch_started_in_panel = {}  

func _input(event):
	if not Touch_control_mode:
		touch_positions.clear()
		touch_started_in_panel.clear()
		return

	if event is InputEventScreenTouch and event.pressed:
		var panel_rect = get_global_rect()
		if panel_rect.has_point(event.position):
			touch_positions[event.index] = event.position
			touch_started_in_panel[event.index] = true
		else:
			touch_started_in_panel[event.index] = false

	elif event is InputEventScreenDrag:
		if event.index in touch_positions and touch_started_in_panel.get(event.index, false):
			var previous_position = touch_positions[event.index]
			var delta = event.position - previous_position
			touch_positions[event.index] = event.position  
			
			_rotate_3D(delta)

	elif event is InputEventScreenTouch and not event.pressed:
		touch_positions.erase(event.index)
		touch_started_in_panel.erase(event.index)

func _rotate_3D(delta: Vector2):
	Object_rotating_on_the_x_axis.rotation_degrees.y -= delta.x * sensitivity_x
	Object_rotating_on_the_y_axis.rotation_degrees.x = clamp(
		Object_rotating_on_the_y_axis.rotation_degrees.x - delta.y * sensitivity_y, -80, 80)


---

วิธีใช้งาน (How to Use)

ภาษาไทย

1. เพิ่ม Panel ใน Scene และแนบสคริปต์นี้เข้าไป


2. กำหนดค่าต่าง ๆ ใน Inspector:

sensitivity_x: ความไวของการหมุนในแกน X

sensitivity_y: ความไวของการหมุนในแกน Y

Object_rotating_on_the_x_axis: ระบุ Node 3D ที่จะหมุนในแกน X

Object_rotating_on_the_y_axis: ระบุ Node 3D ที่จะหมุนในแกน Y

Touch_control_mode: เปิด (true) หรือปิด (false) การควบคุมการสัมผัส



3. รันโปรเจกต์และเริ่มสัมผัสหน้าจอเพื่อควบคุมวัตถุ!



English

1. Add a Panel to your Scene and attach this script


2. Configure the properties in the Inspector:

sensitivity_x: Sensitivity for rotation on the X axis

sensitivity_y: Sensitivity for rotation on the Y axis

Object_rotating_on_the_x_axis: Specify the Node 3D for X axis rotation

Object_rotating_on_the_y_axis: Specify the Node 3D for Y axis rotation

Touch_control_mode: Enable (true) or disable (false) touch controls



3. Run the project and start rotating the object by touching and dragging!




---

License (สัญญาอนุญาต)

This project is licensed under the MIT License. See the LICENSE.txt file for details.

โปรเจกต์นี้อยู่ภายใต้สัญญาอนุญาต MIT สามารถดูรายละเอียดเพิ่มเติมได้ที่ไฟล์ LICENSE.txt

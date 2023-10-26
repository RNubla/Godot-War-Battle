extends CharacterBody2D

var moving:bool = false
var direction:Vector2 = Vector2()

@export var speed:float = 50
@export var Bullet: PackedScene = null

@export var abilities:Array[Node] = []

var gun:Marker2D = null

func _ready():
	gun = $Gun
#	for ability in abilities:
#		self.add_child(ability)
		

func _input(event):
	if event is InputEventMouseMotion:
#		var angle_to_cursor:Vector2 = get_angle_to(get_global_mouse_position())
		gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("weapon_trigger"):
		shoot()

func _physics_process(delta) -> void: 
	velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("sprint"):
		velocity = velocity.normalized() * speed * 1.5
	else:
		velocity = velocity.normalized() * speed
	

	move_and_slide()

func shoot():
	print("Fire!")
	var b = Bullet.instantiate()
	#The problem here is that since the bullets are children of the player, they are affected when the player moves or rotates.
	#To fix this, we should make sure the bullets are added to the world instead. In this case, we’ll use owner, which refers to the root node of the scene the player is in. 
	# Note that we also need to use the muzzle’s global transform, or else the bullet would not be where we expected.
	owner.add_child(b)
	b.transform = gun.global_transform
	

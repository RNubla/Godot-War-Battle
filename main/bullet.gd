extends Area2D

@export var life: float = 2.0
@export var bullet_speed:int = 500
func explode():
	print("explode")
	bullet_speed = 0
	self.rotation = 0	# reset the rotation 
	self.scale.y = -1	#rotate the sprite so that it wont be upsidedown when its played
	$Animations/BulletAnimation.play("explode")
	await $Animations/BulletAnimation.animation_finished

	self.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animations/BulletAnimation.play("rocket")
	var timer: Timer = Timer.new()
	timer.wait_time = life
	#needs to add timer as child to bullet in order for it to function
	add_child(timer)
	timer.start()
	timer.connect("timeout",explode, 1)
	
func _physics_process(delta):
	position += transform.x * bullet_speed * delta

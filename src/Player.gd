extends KinematicBody2D

const GRAVITY = 750
const SPEED = 180
const JUMP = 300
const SIZE = 24

var velocity := Vector2()
var alive := true
var movement_disabled := false
var action_disabled := false

onready var body_sprite := $BodySprite

func _ready():
  pass

func _physics_process(_delta):
  if movement_disabled:
    return

  velocity.x = 0
  velocity.y = 0

  if alive:
    if Input.is_action_pressed("ui_left"):
      velocity.x -= 1
    if Input.is_action_pressed("ui_right"):
      velocity.x += 1
    if Input.is_action_pressed("ui_up"):
      velocity.y -= 1
    if Input.is_action_pressed("ui_down"):
      velocity.y += 1

    velocity = velocity.normalized() * SPEED

  velocity = move_and_slide(velocity, Vector2.UP)

  if velocity.x != 0 || velocity.y != 0:
    body_sprite.play("move")
  else:
    body_sprite.play("idle")

  if velocity.x > 0:
    body_sprite.flip_h = false
  elif velocity.x < 0:
    body_sprite.flip_h = true

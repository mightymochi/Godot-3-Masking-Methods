extends Node2D

var what_stage = -1
var animation_array = ["Intro", "Step2", "Step3", "Outro"]
var is_playing = false
var intro_has_played = false

func _ready():
	pass # Replace with function body.
	#switch_stage()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if what_stage == -1:
			stage_forward()
		else:
			if $AnimationPlayer.is_playing():
				$AnimationPlayer.stop(false)
			else:
				$AnimationPlayer.playback_speed = 1.0
				$AnimationPlayer.play()
	if event.is_action_pressed("ui_left") || event.is_action_pressed("right_click"):
		stage_back()
	if event.is_action_pressed("ui_right") || event.is_action_pressed("left_click"):
		stage_forward()
	if event.is_action_pressed("ui_down"):
		if what_stage == 0:
			reverse_intro()
	
func switch_stage():
	pass
	if intro_has_played && what_stage == 0:
		reverse_intro()
	else:
		normal_play()

func normal_play():
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play(animation_array[what_stage])
	
func reverse_intro():
	intro_has_played = false
	print("REVERSED")
	$AnimationPlayer.playback_speed = 4.0
	$AnimationPlayer.play_backwards("Intro")
	
func stage_forward():
	what_stage += 1
	if what_stage > animation_array.size() - 1:
		what_stage = 0
	switch_stage()

func stage_back():
	what_stage -= 1
	if what_stage < 0:
		what_stage = 2
	switch_stage()

func say_intro_play():
	intro_has_played = true
func say_intro_not_play():
	intro_has_played = false

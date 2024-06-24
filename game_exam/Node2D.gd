extends CanvasLayer

var is_timer = true

var minutes = 0
var seconds = 0
var decimals = 0

var Modo_label = "TIMER"

func update_label():
	$Decimas.text = str(decimals)
	$Tiempo.text = "%02d:%02d"%[minutes,seconds]

func update_stopwatch():
	decimals +=1
	if decimals >=10:
		decimals = 0
		seconds +=1
	if seconds >= 60:
		seconds = 0
		minutes +=1
	if minutes >= 59:
		seconds = 59
		minutes = 59
		decimals = 9
		$Estado.text = "STOPPED"
		$Timer.stop()
		$finish.play()
	update_label()

func update_timer():
	decimals -= 1
	if decimals < 0:
		decimals = 9
		seconds -= 1
	if seconds < 0:
		seconds = 59
		minutes -= 1
	if minutes < 0:
		minutes = 0
		seconds = 0
		decimals = 0
		$Estado.text = "STOPPED"
		$Timer.stop()
		$finish.play()
	update_label()

func _on_boton_b_pressed():
	if $Timer.is_stopped():
		$Timer.start()
		$Estado.text = "RUNNING"
	else:
		$Timer.stop()
		$Estado.text = "STOPPED"

func _on_boton_a_pressed():
	if $Timer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0
		is_timer = !is_timer
		if is_timer == true:
			Modo_label= "TIMER"
		else:
			Modo_label = "STOPWATCH"
	update_label()
	$Modo.text = Modo_label


func _on_boton_d_pressed():
	if $Timer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0
		update_label()


func _on_boton_c_pressed():
	if $Timer.is_stopped() and is_timer == true:
		seconds +=1
		if seconds > 59:
			seconds = 0
		decimals = 0
		update_label()


func _on_boton_e_pressed():
	if $Timer.is_stopped():
		$Timer.start()
		$Estado.text = "RUNNING"
	else:
		$Timer.stop()
		$Estado.text = "STOPPED"


func _on_timer_timeout():
	if is_timer == false:
		update_stopwatch()
	else:
		update_timer()

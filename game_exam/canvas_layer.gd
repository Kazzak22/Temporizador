extends CanvasLayer

var is_timer = true

var minutes = 0
var seconds = 0
var decimals = 0 

var mode_label = 'TIMER'

func update_label():
	$Label.text = str(decimals)
	$TimeLabel.text = '%02d:%02d'%[minutes,seconds]
	
	
func _on_button_pressed():
	if $Timer.is_stopped():
			minutes = 0
			seconds = 0
			decimals = 0 
			is_timer = !is_timer
			if is_timer == true:
				mode_label = 'TIMER'
			else:
				mode_label = 'CRONOMETRO'
	update_label()
	$ModeLabel.text = mode_label


func _on_button_2_pressed():
	if $MainTimer.is_stopped():
			$MainTimer.start()
			$StatusLabel.text = 'CORRE'
	else:
		$MainTimer.stop()
		$StatusLabel.text = 'PARA'


func update_stopwatch():
	decimals += 1
	if decimals >= 10:
		decimals = 0
		seconds += 1
	if seconds >= 60:
		seconds = 0
		minutes += 1
	if minutes >= 59:
		seconds = 59
		minutes = 59
		decimals = 9
		$StatusLabel.text = 'PARA'
		$MainTimer.stop()
		$StopTimerSound.play()
	update_label()

extends Button

func setup(savedata: PlayerSaveFile):
	text = savedata.name
	pass

func empty_setup():
	text = "Empty Slot"
	pass

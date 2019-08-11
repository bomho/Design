# Setting up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "portfolio-3515a"
	secret: "JhhLNRicNl3TmaKQF8bRvWrluNlcgVEGrCNVZy6L"

# Creating the green button
greenButton = new Layer
	y: 500
	width: 400
	height: 400
	backgroundColor: "#00ff00"

greenButton.centerX()

# Setting the default state of the green button
greenButtonOn = true
firebase.put("/greenButtonColor", "#00ff00")

# Creating the red button
redButton = new Layer
	y: 1000
	width: 400
	height: 400
	backgroundColor: "#ff0000"

redButton.centerX()

# Setting the default state of the red button
redButtonOn = true
firebase.put("/redButtonColor", "#ff0000")

# Handle interactions with the green button
greenButton.onClick ->
	if greenButtonOn
		this.backgroundColor = "#999999"
		firebase.put("/greenButtonColor", "#999999")
		greenButtonOn = false
	else 
		this.backgroundColor = "#00ff00"
		firebase.put("/greenButtonColor", "#00ff00")
		greenButtonOn = true

# Handle interactions with the red button
redButton.onClick ->
	if redButtonOn
		this.backgroundColor = "#999999"
		firebase.put("/redButtonColor", "#999999")
		redButtonOn = false
	else 
		this.backgroundColor = "#ff0000"
		firebase.put("/redButtonColor", "#ff0000")
		redButtonOn = true

# Listens for changes on Firebase
firebase.onChange "/greenButtonColor", (greenButtonColor) ->
	greenButton.backgroundColor = greenButtonColor
	
firebase.onChange "/redButtonColor", (redButtonColor) ->
	redButton.backgroundColor = redButtonColor



	

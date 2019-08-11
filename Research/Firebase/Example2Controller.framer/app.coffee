# Setting up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "portfolio-3515a"
	secret: "JhhLNRicNl3TmaKQF8bRvWrluNlcgVEGrCNVZy6L"

# Creating button
triggerButton = new Layer
	width: 800
	height: 400
	backgroundColor: "#00ff00"
triggerButton.centerX()
triggerButton.centerY()

# Setting default state
showNotification = false

# Handle interactions with the button
triggerButton.onClick ->
	if showNotification
		firebase.put("/notification", false)
		triggerButton.backgroundColor = "#ff0000"
		showNotification = false
	else
		firebase.put("/notification", true)
		triggerButton.backgroundColor = "#00ff00"
		showNotification = true
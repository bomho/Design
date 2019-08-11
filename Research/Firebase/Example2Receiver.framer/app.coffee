# Setting up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "YOUR INFO HERE"
	secret: "YOUR INFO HERE"

# Creating the notification
notification = new Layer
	y: -300
	width: 4000
	height: 300
	backgroundColor: "#00ff00"

# Listen for changes to Firebase
firebase.onChange "/notification", (showNotification) ->
	if showNotification
		notification.animate
			properties:
				y: 0
	else
		notification.animate
			properties:
				y: -300
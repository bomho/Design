# Setting up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "YOUR INFO HERE"
	secret: "YOUR INFO HERE"

# Creating the movable object
movableObject = new Layer
	width: 400
	height: 400
	backgroundColor: "white"

movableObject.draggable.enabled = true
movableObject.draggable.momentum = false

# Handle interactions with object
movableObject.on Events.DragStart, ->
	movableObject.animate
		backgroundColor: "#ff0000"

movableObject.on Events.DragEnd, ->
	firebase.put("/objectPosX", movableObject.x)
	firebase.put("/objectPosY", movableObject.y)
	firebase.put("/objectTouch", false)
	movableObject.backgroundColor = "#ff0000"

# Listen for changes to Firebase
firebase.onChange "/objectPosX", (movableObjectX) ->
	movableObject.animate
		x: movableObjectX
	
firebase.onChange "/objectPosY", (movableObjectY) ->
	movableObject.animate
		y: movableObjectY
		
firebase.onChange "/objectTouch", (touched) ->
	if touched
		movableObject.animate
			backgroundColor: "#00ff00"
	else
		movableObject.animate
			backgroundColor: "#ff0000"

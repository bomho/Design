# Setting up Firebase
{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "YOUR INFO HERE"
	secret: "YOUR INFO HERE"

# Create movable object
movableObject = new Layer
	width: 400
	height: 400
	backgroundColor: "white"

movableObject.draggable.enabled = true
movableObject.draggable.momentum = false

# Handle interactions with object
movableObject.on Events.DragStart, ->
	movableObject.animate
		backgroundColor: "#00ff00"

movableObject.on Events.DragEnd, ->
	firebase.put("/objectPosX", movableObject.x)
	firebase.put("/objectPosY", movableObject.y)
	firebase.put("/objectTouch", true)
	
# Listen for changes to Firebase
firebase.onChange "/objectPosX", (movableObjectX) ->
	movableObject.animate
		x: movableObjectX
	
firebase.onChange "/objectPosY", (movableObjectY) ->
	movableObject.animate
		y: movableObjectY
		
firebase.onChange "/objectTouch", (touched) ->
	if touched
		movableObject.backgroundColor = "#00ff00"
	else
		movableObject.backgroundColor = "#ff0000"

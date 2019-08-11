{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: ""
	secret: ""

date = new Date()

putbtn = new Layer
	width: Screen.width
	maxY: Screen.height
	backgroundColor: "#0000ff"

putbtn.bringToFront()

putbtn.onTap ->
	now = date.toLocaleTimeString()
	nowTime = 1 + now[8..9]
	firebase.put("/now", nowTime)
	print "click", now

firebase.onChange "/now",(nowTime) ->
	time = date.toLocaleTimeString()
	putTime = 1 + time[8..9]
	print 	"변화 시간 : " + putTime,	"넣은 시간 : " + nowTime
	Latency = putTime - nowTime
	firebase.put "/delay", (Latency)
# 	print "걸리는 시간 : " + Latency

# Create text layer with template tags. 
layerA = new TextLayer
	text: "Firebase Latency : {speed}{unit}"
 
# Format template value to only have 2 decimals. 
layerA.templateFormatter = 
	speed: (value) ->
		Utils.round(value,2)

firebase.onChange "/delay",(Latency) ->
	firebase.get "/delay",(Latency) ->
		# Animate template value from 0 to 100. 
		layerA.animate
			template: 
				speed: Latency
				unit: "ms"


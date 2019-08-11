{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "portfolio-3515a"
	secret: "JhhLNRicNl3TmaKQF8bRvWrluNlcgVEGrCNVZy6L"

# firebase 삽입시 시간 확인
# firebase 삽입 완료시 시간 확인
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


firebase.onChange "/now",(nowTime) ->
	time = date.toLocaleTimeString()
	putTime = 1 + time[8..9]
# 	print 	"변화 시간 : " + putTime,	"넣은 시간 : " + nowTime
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
	# Animate template value from 0 to 100. 
	layerA.animate
		template: 
			speed: Latency
			unit: "ms"



{Firebase} = require 'firebase'

firebase = new Firebase
	projectID: "portfolio-3515a"
	secret: "JhhLNRicNl3TmaKQF8bRvWrluNlcgVEGrCNVZy6L"

# Gradient Layer Tset 
grayscale = new Gradient
	start: new Color("#fff")
	end: new Color("#aaa")
	angle: 180

gradiLayer = new Layer
	gradient : grayscale
	width: Screen.width
	height: Screen.width/2

namesArray = []

# 각각 하위 요소를 넣어야 한다.
# ex : start가 가지고 있는 값.
gradiLayer.onTap ->
	firebase.put("/gradient",grayscale.start.color)
	# Simple 2, expecting dataset
	firebase.get "/gradient", (gradient) ->
		namesArray = _.toArray(gradient) # converts JSON to array
	# 	print name for name in namesArray
		print namesArray 



# Image Layer Test
imgLayer = new Layer
	y: gradiLayer.maxY
	width: Screen.width
	height: Screen.width
# 	image: "images/a.jpg"

imgLayer.onTap ->
	firebase.put("/img",imgLayer.image)
	
btnDel = new Layer
	width: Screen.width/2
	height: Screen.width/6
	midX: Screen.width/2
	midY: Screen.width/2
	borderRadius: 4
	backgroundColor: "#EE2E5F";

latencytx = new TextLayer
	parent: btnDel
	text: "Delete Latency"
	fontSize: 20
	color: "#fff"
	x : Align.center
	y : Align.center
	
# Console에서 레이턴시를 띄우고 싶고
# 그 레이턴시를 데이터에 넣어서 체크하고 싶다.

latencytx.onTap ->
	latencytx.textReplace("Delete Latency", "{speed}{unit}")
	# Format template value to only have 2 decimals. 
	latencytx.templateFormatter = 
		speed: (value) ->
			Utils.round(value, 2)
			
	# Animate template value from 0 to 100. 
	latencytx.animate
		template: 
			speed: 100
			unit: "ms"

# Data Delete
btnDel.onTap ->
	firebase.delete("/gradient")
	firebase.get "/gradient", (gradient) ->
		namesArray = _.toArray(gradient) # converts JSON to array
	# 	print name for name in namesArray
		print namesArray, time

 
# advanced data put 
response = (confirmation) ->
	print confirmation
	
# firebase.put("/values", {"foo": true, "bar": false}, response)
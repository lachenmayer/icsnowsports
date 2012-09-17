# Snap out elastic effect
#
# Stolen shamelessly from YUI's Easing class and converted to CoffeeScript.
# http://yuilibrary.com/yui/docs/api/files/anim_js_anim-easing.js.html#l171
#
# @method elasticOut
# @param {Number} t Time value used to compute current value
# @param {Number} b Starting value
# @param {Number} c Delta between start and end values
# @param {Number} d Total length of animation
# @param {Number} a Amplitude (optional)
# @param {Number} p Period (optional)
# @return {Number} The computed value for the current animation frame
elasticOut = (t, b, c, d, a, p) ->
	if (t == 0)
		return b
	if ( (t /= d) == 1 )
		return b+c
	if (!p)
		p=d*.3
	if (!a || a < Math.abs(c))
		a = c
		s = p / 4
	else
		s = p/(2*Math.PI) * Math.asin (c/a)
	a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b

relativeElasticOut = (size, length) ->
	values = [0]
	for i in [1..length]
		values[i] = (elasticOut i, 0, size, length) - (elasticOut (i-1), 0, size, length)
	values



# Color helper methods

rgb = (c) ->
	result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(c)
	if result then {
		r: parseInt(result[1], 16)
		g: parseInt(result[2], 16)
		b: parseInt(result[3], 16)
	} else null

hex = (c) ->
	'#' + ((1 << 24) + (c.r << 16) + (c.g << 8) + c.b).toString(16).slice(1)

interpolateColor = (fg, bg, coeff) ->
	fgRgb = rgb fg
	bgRgb = rgb bg
	intComp = (c) ->
		Math.floor(bgRgb[c] + (fgRgb[c] - bgRgb[c]) * coeff)
	newRgb = {
		r: intComp 'r'
		g: intComp 'g'
		b: intComp 'b'
	}
	hex newRgb



# The real fun

paper.install(window)

$ ->
	paper.setup 'canvas'
	fg = '#ffffff'
	bg = '#8dd1da'
	
	$('a').smoothScroll()
	
	canvasHeight = $('#canvas').height()
	
	$('#content').css 'top', canvasHeight
	
	mountains = []
	
	animationSize = 100
	animationTime = 30
	
	animationOffsets = relativeElasticOut -animationSize, animationTime
	
	
	class Mountain
		constructor: (@x, @y, @fg, @bg, @z) ->
			@mountain = new Path.RegularPolygon new Point(x, canvasHeight + animationSize), 3, (canvasHeight + animationSize) - y
			@mountain.fillColor = interpolateColor fg, bg, z
			@t = 0
	
	$(document).mousedown (event) ->
		m = new Mountain event.screenX, event.screenY, fg, bg, Math.random()
		mountains.push m
		view.draw()
	
	view.onFrame = (event) ->
		return if mountains.length == 0
		for i in [mountains.length-1...0]
			m = mountains[i]
			if m.t <= animationTime
				m.mountain.translate [0, animationOffsets[m.t]]
				m.t++
			else
				mountains.splice i, 1


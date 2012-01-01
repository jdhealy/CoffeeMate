coffee = require 'coffee-script'

# TODO: make sure process.stdout isn't writing before sending write

code = """
sys = require('/Users/jdhealy/Library/Application Support/Avian/Bundles/CoffeeScript.tmbundle/Support/colorLog/sys.js') \n
color = sys.color

console.log = ->
	display = (arg) =>
		if @color then process.stdout.write "<section style='background-color:" + @color + "'>"
		unless typeof arg is 'string'
			# process.stdout.write("<h1>@all: " + this.all + "</h1>");
			color = switch @all
				when 1 then sys.color.all
				when 2 then sys.color.All
				else sys.color
			color arg
		else
			process.stdout.write "<pre class='string'><code>" + arg + "</code></pre>"
		if @color then process.stdout.write "</section>"
	
	unless arguments.length > 1 and arguments.length isnt 0
		display arguments[0]
	else
		process.stdout.write "<article class='console_log'>"
		for arg in arguments
			display arg
		process.stdout.write "</article>"

console.log.all = -> console.log.apply {all: 1}, arguments
console.log.All = -> console.log.apply {all: 2}, arguments

sys.color.colors = {'blue': "0095cd"}
for key, value of sys.color.colors
	console.log[key] = -> console.log.apply {'color': value}, arguments
	console.log.all[key] = -> console.log.apply {'all': true, 'color': value}, arguments

# console.log.blue = -> console.log.apply {color: "0095cd"}, arguments
# console.log.all.blue = -> console.log.apply {all: true, color: "0095cd"}, arguments
\n
"""
process.stdin.resume()
process.stdin.setEncoding('utf8')
process.stdin.on 'data', (data) -> code += data

process.stdin.on 'end', =>
	# process.stdout.write "<pre>#{code}</pre>"
	coffee.eval code
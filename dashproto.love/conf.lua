-- Configuration
function love.conf(t)
	t.title = "Dash proto" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LÖVE version this game was made for (string)
	t.window.borderless = true
	t.window.width = 768
	t.window.height = 720

	-- For Windows debugging
	t.console = true

	debug = {
		boxes = true,
		loglevel = 'DEBUG' --TODO make debug level work
	}

	resx = 256
	resy = 240
	multx = 3
	multy = 3
	tilesize = 16
	maxlayer = 10
	minlayer = 1
	maxorders = 5
	minorders = 1
end

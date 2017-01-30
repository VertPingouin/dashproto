-- Configuration
function love.conf(t)
	t.title = "Dash proto" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LÖVE version this game was made for (string)
	t.window.borderless = true
	t.window.width = 1024
	t.window.height = 768

	-- For Windows debugging
	t.console = true

	debug = {
		boxes = true,
		loglevel = 'DEBUG' --TODO make debug level work
	}
	tilesize = 32
	maxlayers = 10
	maxorders = 5
end

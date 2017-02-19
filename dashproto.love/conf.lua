-- Configuration
function love.conf(t)
	params = {
	maxfps = 40,
	nativeresx = 256,
	nativeresy = 240,
	multx = 3,
	multy = 3,
	resx = 768,
	resy = 720,
	tilesize = 16,
	maxlayer = 10,
	minlayer = 1,
	maxorder = 5,
	minorder = 1,
	debug = {
		boxes = false,
		fps = true,
		console = false,
		look = false,
		log = true
		}
	}

	t.title = "Dash proto" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LoVE version this game was made for (string)
	t.window.borderless = true
	t.window.width = 768
	t.window.height = 720

	-- For Windows debugging
	t.console = true
end

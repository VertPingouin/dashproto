-- Configuration
function love.conf(t)

	params = {
	maxfps = 60,
	nativeresx = 256,
	nativeresy = 240,
	tilesize = 16,
	maxlayer = 10,
	minlayer = 1,
	maxorder = 5,
	minorder = 1,
	limitfps = true,
	vsync = true,
	fullscreen = true,
	debug = {
		boxes = false,
		names = false,
		fps = false,
		console = false,
		look = false,
		log = false,
		}
	}


	t.title = "SkellySpawn" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LoVE version this game was made for (string)
	t.window.borderless = true
	--t.window.width = 768
	--t.window.height = 720

	-- For Windows debugging
	t.console = true
end

module Graphics where

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLImage

import Mechanics
import Sprites

load_spritesheet :: IO ()
load_spritesheet = return ()

initialize_graphics :: IO (Maybe Surface)
initialize_graphics = do
	SDL.init [InitEverything]
	trySetVideoMode 640 480 32 []
	SDL.setCaption "Shuttle" "Shuttle"
	tryGetVideoSurface

kill_graphics :: IO ()
kill_graphics = do
	SDL.quit

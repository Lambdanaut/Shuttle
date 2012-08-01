module Sprites where

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLImage

import Mechanics

type Sprite_Coords = (Int, Int, Int, Int)
type Spritesheet_Meta = [ (Graphics_State, [ (Dir, [Sprite_Coords] ) ] ) ] 

data Spritesheet = Spritesheet {
	  spritesheet_surface :: Surface 
	, spritesheet_meta :: Spritesheet_Meta
} deriving Show

data Graphics_State = Stationary | Moving | Attacking | Casting1 | Casting2 deriving (Show, Read, Enum, Ord, Eq)

load_spritesheet :: FilePath -> Spritesheet_Meta -> IO Spritesheet
load_spritesheet filepath meta = do
	image <- SDLImage.loadTyped filepath SDLImage.PNG
	return $ Spritesheet image meta

get_sprite_coords :: Graphics_State -> Dir -> Spritesheet -> Maybe [Sprite_Coords]
get_sprite_coords graphics_state dir spritesheet = do
	let meta = spritesheet_meta spritesheet
	state_filtered <- lookup graphics_state meta
	lookup dir state_filtered

t :: Spritesheet_Meta
t = [ (Stationary, [ (N, [(0,0,50,50)] ) ] ) ]

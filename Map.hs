module Map where

import Data.Vector
import Control.Monad.State

-- The width and height of a single terrain unit on the map
map_resolution = 25

data Terrain = Mud deriving (Show, Read, Enum, Ord, Eq)

data Map = Map {
	map_name    :: String
,	map_width   :: Int
,	map_height  :: Int
,	map_terrain :: Vector (Vector Terrain)
} deriving (Show, Read)

load_map :: FilePath -> IO Map
load_map map_path = fmap read $ readFile map_path

save_map :: FilePath -> Map -> IO ()
save_map map_path world_map = writeFile map_path (show world_map)

create_map :: String -> [[Terrain]] -> Map
create_map name terrain_list = Map name width height (fromList $ Prelude.map fromList terrain_list)
  where	width  = Prelude.length terrain_list
	height = if width > 0 then Prelude.length $ terrain_list !! 0 else 0

template_map :: String -> Map
template_map name = create_map name [ [Mud ..] | x <- [1 .. Prelude.length [Mud ..] ] ]

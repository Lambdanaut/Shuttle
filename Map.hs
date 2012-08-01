module Map where

import Control.Monad.State
import qualified Data.Vector as Vector

import Mechanics
import qualified Util

-- The width and height of a single terrain unit on the map
map_resolution = 25

data Terrain = Mud | Plains | Wall | Empty_Terrain deriving (Show, Read, Enum, Ord, Eq)

data Map = Map {
	map_name    :: String
,	map_width   :: Int
,	map_height  :: Int
,	map_terrain :: Vector.Vector (Vector.Vector Terrain)
} deriving (Show, Read)

load_map :: FilePath -> IO Map
load_map map_path = fmap read $ readFile map_path

save_map :: FilePath -> Map -> IO ()
save_map map_path world_map = writeFile map_path (show world_map)

create_map :: String -> [[Terrain]] -> Map
create_map name terrain_list = Map name width height (Vector.fromList $ map Vector.fromList terrain_list)
  where	width  = length terrain_list
	height = if width > 0 then length $ terrain_list !! 0 else 0

in_bounds :: Map -> Pos -> Bool
in_bounds world_map (x, y) 
  | x >= 0 && y >= 0 && x < w && y < h = True
  | otherwise = False
  where	w = map_width world_map
	h = map_height world_map

map_index :: Map -> Pos -> Terrain
map_index world_map (x, y) = if in_bounds world_map (x, y) then terrain Vector.! x Vector.! y else Empty_Terrain
  where terrain = map_terrain world_map

map_neighbors :: Map -> Pos -> [Pos]
map_neighbors world_map (x1, y1) = filter (in_bounds world_map) $ map (\(x2,y2) -> (x1 + x2, y1 + y2) ) $ map dir_pos all_directions

template_map :: String -> Map
template_map name = create_map name [ [Mud ..] | x <- [1 .. length [Mud ..] ] ]

traversable :: Terrain -> Bool
traversable t = case t of
	Wall -> False
	otherwise -> True

aStar :: Map -> Pos -> Pos -> [Pos]
aStar world_map start goal = fst $ runState stateful_aStar (start, [(start,start,0)],[])
  where	stateful_aStar = do
		(cur_point, open, closed) <- get
		let neighbors = filter (\point -> not (elem point closed) && (traversable $ map_index world_map point) ) $ map_neighbors world_map cur_point -- Get all traversable neighbors that are not on the closed list
		let open__ = (filter (\(p,_,_) -> p /= cur_point) open ) ++ (map (\ point -> (point, cur_point, heuristic point ) ) neighbors) -- Drop the current point from the open list and add the neighbors
		let closed_ = cur_point : closed -- Add the current point to the closed list
		return $ map Util.fst open__
	(x1, y1) = start
	(x2, y2) = goal
	heuristic (x,y) = sqrt.fromIntegral $ (x2 - x)^2 + (y2 - y)^2 

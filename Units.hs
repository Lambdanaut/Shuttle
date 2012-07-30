module Characters where

import Graphics
import Mechanics
import Sprites

data Unit_Name = Infantry | Tank deriving (Show, Read, Enum, Ord, Eq)

data Unit = Unit {
	unit_name      :: Unit_Name
,	unit_max_hp    :: Int
,	unit_cur_hp    :: Int
,	unit_max_mp    :: Int
,	unit_cur_mp    :: Int
,	unit_pos       :: Pos
,	unit_dir       :: Dir
,	unit_spriteset :: Spriteset
} deriving (Show, Read)

